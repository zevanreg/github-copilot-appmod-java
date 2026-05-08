# Step-by-Step Modernization Guide (v2)

## Using GitHub Copilot modernization for Java

**Duration:** 90 minutes (guided exercises)
**Audience:** Developers new to GitHub Copilot modernization for Java
**Prerequisites:** Completed [Pre-requisites](./hackathon-prerequisites.md) and reviewed [App Background](./legacy-app-background.md)

> **What's new in v2:** trimmed to fit the 90-minute time box, removed duplicated content between sections, corrected the Sybase → Azure SQL story to match the actual predefined tasks, clarified the Claude 4.6 vs `AppModernization` agent (Claude 4.5) split, and re-anchored Sections 8–10 as *verification of what the agent generated* rather than parallel manual work.

---

## Table of Contents

1. [Getting Started with GitHub Copilot](#1-getting-started-with-github-copilot)
2. [Opening the Legacy Application](#2-opening-the-legacy-application)
3. [Tour the GitHub Copilot Modernization Pane](#3-tour-the-github-copilot-modernization-pane)
4. [Running an Assessment](#4-running-an-assessment)
5. [Understanding Assessment Results](#5-understanding-assessment-results)
6. [Plan and Apply Migration Tasks](#6-plan-and-apply-migration-tasks)
7. [Database Migration: Sybase to Azure SQL](#7-database-migration-sybase-to-azure-sql)
8. [Verify the Modernized Application (Stretch)](#8-verify-the-modernized-application-stretch)
9. [Cloud Deployment (Stretch)](#9-cloud-deployment-stretch)
10. [Best Practices and Wrap-up](#10-best-practices-and-wrap-up)

### Suggested 90-minute timing

| Block | Section | Min |
|---|---|---|
| Setup & context | 1 + 2 | 10 |
| Tool tour | 3 | 3 |
| Assessment | 4 | 12 |
| Interpret report | 5 | 15 |
| **Predefined task end-to-end** (the headline experience) | 6 | 35 |
| Database migration deep-dive | 7 | 10 |
| Wrap & Q&A | 10 | 5 |

Sections **8 (verification)** and **9 (deployment)** are *stretch goals* for self-paced follow-up after the 90 minutes.

---

## 1. Getting Started with GitHub Copilot

### Two AI roles you'll use today

This is the single most important concept in the workshop. There are **two distinct AI surfaces** in play, and they use different models on purpose:

| Surface | When you use it | Model |
|---|---|---|
| **Copilot Chat** (you drive) | Asking *why*, *what*, *explain*, *compare*, ad-hoc help | Pick **Claude Sonnet 4.6** in the chat model picker |
| **`AppModernization` custom agent** (the extension drives) | Whenever you click **Run Task** or **Upgrade Runtime & Frameworks** | Defaults to **Claude Sonnet 4.5**, falls back to `auto` — **don't change it** |

When you launch a predefined task, the chat panel automatically switches to the `AppModernization` agent. That switch is expected. After the task finishes you can switch back to your normal model for follow-up questions.

### Use Copilot Chat for asking. Use predefined tasks for transforming code.

| Use Copilot Chat for... | Use a Predefined Task for... |
|---|---|
| Asking *why*, *what*, *explain*, *compare* | Code transformations the tool ships |
| Reviewing the diff after a task | Anything in the [predefined tasks list](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-predefined-tasks) |
| One-off questions | Driving the validation iteration loop |

---

### Exercise 1.1: Verify Copilot Chat and your model (3 minutes)

1. Open the **Chat panel**: press `Ctrl + Alt + I` (Windows/Linux) or `Cmd + Alt + I` (macOS), or click the chat icon in the Activity Bar.
   > Note: `Ctrl + I` opens **inline chat** (a popover in the editor). For this workshop you want the **panel**.

2. In the model dropdown at the top of the chat panel, select **Claude Sonnet 4.6** (preferred) or **Claude Sonnet 4.5** (acceptable fallback). If neither appears, see the [Prerequisites](./hackathon-prerequisites.md#43-select-claude-sonnet-46-as-your-model-recommended).

3. Verify with one prompt:

   ```text
   What model are you using?
   ```

**✓ Checkpoint:** Chat panel is open, model dropdown shows Claude Sonnet 4.6 (or 4.5).

---

## 2. Opening the Legacy Application

### Exercise 2.1: Open the project and build (5 minutes)

1. Open the workspace in VS Code:

   ```bash
   cd c:\github\github-copilot-appmod-java
   code .
   ```

2. **Trust the workspace** when prompted. Wait for **Java: Ready** in the status bar.

3. **Confirm a clean Git working tree** — the modernization agent will check out a new branch when you run a task. From the integrated terminal:

   ```bash
   git status
   ```

   Stash or commit any pending changes before continuing.

4. Build once to confirm the legacy app compiles as-is:

   ```bash
   cd app
   mvn clean package
   ```

   Expected output: `BUILD SUCCESS` and a WAR under `target/`.

**✓ Checkpoint:** Legacy app builds, Git tree is clean.

---

### Exercise 2.2: One-minute codebase tour (2 minutes)

Open the **Chat panel** and ask:

```text
@workspace Summarize this Java application: architecture, frameworks, the database it uses, and the top 3 modernization concerns you can spot.
```

You should see Copilot identify: legacy Servlet/JSP, Sybase ASE JDBC driver, hardcoded credentials in `DatabaseConnection.java`, and Java 8.

**✓ Checkpoint:** You have a one-paragraph mental model of the app before running the assessment.

---

## 3. Tour the GitHub Copilot Modernization Pane

### Exercise 3.1: Open and orient (3 minutes)

Click the **GitHub Copilot modernization** icon in the Activity Bar. The pane has four sections — you will use the first three today:

| Pane section | What it does |
|---|---|
| **QUICKSTART** | One-click entry points: **Start Assessment**, **Upgrade Runtime & Frameworks** |
| **ASSESSMENT REPORTS** | Every assessment run produces an independent report you can revisit, import, export, or delete |
| **TASKS** | Three subgroups: **Upgrade Tasks**, **Migration Tasks**, **Quality & Security Tasks** |
| **CUSTOM SKILLS** | Advanced/enterprise extension points — out of scope for this workshop |

> **Tooling prerequisites recap:** GitHub Copilot modernization itself requires VS Code 1.106+ and **Java 21+** on your PATH (separate from the legacy app's Java 8 runtime). Maven 3.6+ or the Gradle wrapper 5+. Verify with `java -version` if the pane shows tooling errors.

> **No additional settings to configure.** The extension does not require workspace-level configuration to run an assessment. All choices (target JDK, target Azure compute, containerization) are made *inside* the assessment dialog in the next section.

**✓ Checkpoint:** You can identify QUICKSTART, ASSESSMENT REPORTS, and TASKS in the pane.

---

## 4. Running an Assessment

> Reference: [Working with assessment - GitHub Copilot modernization for Java](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-working-with-assessment?pivots=vscode)

The assessment is the entry point to every other workflow. Each run produces an independent report you can compare over time.

---

### Exercise 4.1: Run a Recommended Assessment (8 minutes)

For the workshop, **always start with a Recommended Assessment** — Custom Assessment is reserved for fine-tuned enterprise scenarios.

1. In the modernization pane, **QUICKSTART → Start Assessment**.

   ![Start Assessment](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/run-assessment-visual-studio-code.png)

2. Select **Recommended Assessment**.

3. **Select the domains** — for this workshop choose **Cloud Readiness** and **Java Upgrade**. (Optionally add **Security** to see ISO 5055 / CWE findings; adds ~30 seconds.)

   ![Recommended Assessment](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/recommended-assessment.png)

4. Select **OK** to start the assessment. Expect 1–3 minutes for this codebase.

5. When the analysis finishes, the **interactive dashboard** opens automatically and a new entry appears under **ASSESSMENT REPORTS**.

**✓ Checkpoint:** A new assessment report is open in the editor and listed in the pane.

> **Custom Assessment (skip for the workshop):** Use Custom Assessment when you need to target specific Azure compute services (App Service, AKS, ACA), pick an OS (Linux/Windows), pin a JDK target, or enable **Containerization** analysis. The configuration UI is documented in the [reference link above](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-working-with-assessment?pivots=vscode).

---

### Exercise 4.2: Manage assessment reports (4 minutes)

Each run produces an independent report. From the report list you can:

- **Import** an existing report — accepts AppCAT CLI `report.json`, an exported GitHub Copilot modernization report, or a Dr. Migrate app context file.

  ![Import assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/import-assessment-report-visual-studio-code.png)

- **Export** a report (the report's **...** menu → **Export**) to share with teammates without rerunning.

  ![Export assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/export-assessment-report-visual-studio-code.png)

- **Delete** old reports (**...** → **Delete**).

  ![Delete assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/delete-assessment-report-visual-studio-code.png)

> **Enterprise context (FYI, no action required):** In production, assessments often *come from* portfolio tools — **Azure Migrate** or **Dr. Migrate** discover candidate apps across a fleet and emit a report you import here. See [portfolio assessment integration](https://learn.microsoft.com/en-us/azure/developer/java/migration/github-copilot-app-modernization-for-java-portfolio-assessment-integration). Today we run the assessment locally on a single sample app.

**✓ Checkpoint:** You know how to view, import, export, and delete reports.

---

## 5. Understanding Assessment Results

> References: [Understand assessment coverage](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-assess-rules) · [Interpret the assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-working-with-assessment?pivots=vscode#interpret-the-assessment-report)

The report has three layers: top-level **Application Information**, an **Issue Summary** by domain and criticality, and four detail tabs: **Issues**, **Dependencies**, **Technologies**, **Insights**.

---

### Exercise 5.1: Tour the four tabs (5 minutes)

![Assessment report dashboard](/images/assessment-report-summary.png)

#### Issues tab

Categorized list of issues across Cloud Readiness, Java Upgrade, and Security.

| Criticality | Meaning |
|---|---|
| **Mandatory** | Must fix to migrate. Treat as blockers. |
| **Potential** | Might affect migration. Review case-by-case. |
| **Optional** | Low impact. Fix if time permits. |

![Issue list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-issue-list-visual-studio-code.png)

Expand any issue to see incident files, line counts, the problem description, known solutions, and links to **Run Task** if a predefined task is available.

![Issue detail](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-issue-detail-visual-studio-code.png)

#### Dependencies tab

All Java-packaged dependencies discovered.

![Dependency list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-dependency-list-visual-studio-code.png)

#### Technologies tab

Embedded libraries grouped by function — a quick functional fingerprint of the app.

![Technology list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-technology-list-visual-studio-code.png)

#### Insights tab

File-level details supporting the technology detection.

![Insight list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-insight-list-visual-studio-code.png)

---

### Exercise 5.2: Issue coverage by domain (5 minutes)

Cross-reference what you see in your **Issues** tab with the rule catalog below.

#### Domain: cloud-readiness (16 rules)

| Rule | What it detects |
|------|-----------------|
| credential-migration | Hardcoded cloud credentials and embedded secret-management libraries |
| region-configuration | Hardcoded cloud region identifiers |
| storage-migration | Vendor object-storage SDK usage (AWS S3, GCS) |
| messaging-service-migration | SQS/SNS, Kafka, RabbitMQ, ActiveMQ, IBM MQ, Pub/Sub dependencies |
| **database-migration** | Drivers and connection strings for MongoDB, MySQL, PostgreSQL, MSSQL, Cassandra, MariaDB, Oracle, Db2, **Sybase ASE**, etc. |
| file-system-management | Local filesystem reads/writes that break in ephemeral containers |
| local-credential | `.jks` keystore files and clear-text passwords |
| configuration-management | OS-specific or local-file configuration |
| session-management | `HttpSession` state and the `distributable` web descriptor tag |
| remote-communication | CORBA, RMI, JCA, raw sockets, hardcoded URLs |
| jakarta-migration | Jakarta/Java EE APIs and proprietary JBoss/WebLogic/WebSphere artifacts |
| containerization | Missing or problematic Dockerfile |
| scheduled-job-migration | Quartz, Spring Batch, Lambda handlers |
| apm-migration | Embedded New Relic / Elastic APM / Dynatrace agents |
| auth-migration | SAML, OAuth 2.0, OpenID, Spring Security, LDAP, legacy webform auth |
| os-compatibility | Windows-specific `.dll` dependencies |

**Expected for our app:** **database-migration** (Sybase ASE driver), **credential-migration** / **local-credential** (hardcoded `sa` / `Welcome1234!`), **session-management** (servlet `HttpSession`), **containerization** (no Dockerfile).

#### Domain: java-upgrade (4 rules)

| Rule | What it detects |
|------|-----------------|
| java-version-upgrade | Non-LTS or legacy Java (1.x–8, 9, 10, 12–16, 19, 20) |
| framework-upgrade | Spring Boot / Spring Framework / Jakarta EE past EOL |
| deprecated-apis | Hundreds of removed/deprecated APIs (`sun.misc.BASE64`, `Thread.stop`, etc.) |
| build-tool | Legacy build systems like Ant or Eclipse-specific WTP/JEM project natures |

**Expected for our app:** **java-version-upgrade** (Java 8).

#### Domain: Security (ISO 5055 — 42 CWEs)

The Security domain detects 42 CWEs curated from [ISO/IEC 5055](https://www.it-cisq.org/standards/code-quality-standards/) — the 8% of flaws that cause 90% of production issues. Highlights you may see in this codebase:

| CWE | Title |
|---|---|
| **CWE-259 / CWE-798** | Hard-coded password / credentials |
| **CWE-89** | SQL Injection |
| CWE-79 | Cross-site Scripting |
| CWE-22 / CWE-23 / CWE-36 | Path Traversal variants |
| CWE-77 / CWE-78 / CWE-88 | Command and Argument Injection |
| CWE-502 | Deserialization of Untrusted Data |
| CWE-611 | XML External Entity (XXE) |
| CWE-732 | Incorrect Permission Assignment |
| CWE-772 / CWE-775 | Missing Release of Resource / File Descriptor |
| CWE-778 | Insufficient Logging |

**Expected for our app:** **CWE-798 / CWE-259** flagging hardcoded credentials in `DatabaseConnection.java`; **CWE-89** if any string-concatenated SQL is found in `UserDAO.java`.

---

### Exercise 5.3: Build a task plan grounded in real predefined tasks (5 minutes)

Now translate the report into a sequence of **predefined tasks** you can actually run. The tasks below are in the official [Predefined tasks](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-predefined-tasks) catalog.

| # | Issue in report | Predefined task to run | Section |
|---|---|---|---|
| 1 | Mandatory: Java 8 | **Upgrade Runtime & Frameworks** (QUICKSTART) | 6.2 |
| 2 | Mandatory: Sybase ASE driver + credentials | **Managed Identities for Database migration to Azure** (Azure SQL target) | 7 |
| 3 | Mandatory: Hardcoded credentials | **Secrets and Certificate Management to Azure Key Vault** | 6.3 |
| 4 | Optional: Logging | **Logging to local file** (route to console for cloud) | Skip / stretch |
| 5 | Quality | **Generate Unit Test Cases** (Quality & Security Tasks) | 6.5 |

**Predefined tasks you can run later (full menu):** Spring RabbitMQ → Service Bus · ActiveMQ → Service Bus · AWS SQS → Service Bus · Managed Identities for Event Hubs / Service Bus Credential Migration · AWS S3 → Azure Blob · Local File I/O → Azure Files · Java Mail → Azure Communication Services · User Auth → Entra ID · SQL Dialect Oracle → PostgreSQL · AWS Secrets Manager → Key Vault.

**✓ Checkpoint:** You have a 3-task hackathon plan tied to actual buttons in the pane.

---

## 6. Plan and Apply Migration Tasks

> Reference: [Quickstart: Assess and migrate a Java project using GitHub Copilot modernization](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-quickstart-assess-migrate?pivots=vscode)

This is the **headline experience** of the workshop. Budget ~35 minutes here.

### How the agent drives — read this once

When you click **Run Task** the chat panel switches to the `AppModernization` agent on **Claude Sonnet 4.5** and follows this loop:

1. Generates `plan.md` (the proposed migration plan) and `progress.md` (live tracker) in your repo.
2. Checks out a **new Git branch** for the migration.
3. Applies code changes with several internal tools.
4. Runs the **5-tool validation iteration** until the build, tests, and consistency checks pass.
5. Generates a **migration summary** and asks you to **Keep** the changes.

> ⚠️ **How you drive the agent:** the agent pauses for confirmation between tool calls. Each pause has two equivalent options:
>
> - **Click the `Continue` button** in the chat, **or**
> - **Type `continue`** in the chat input and press Enter.
>
> Expect to do this 10–20 times during a full migration. This is by design — read the agent's message before each Continue so you understand what tool is about to run.

**The 5 validation tools (run in this order):**

| # | Tool | What it does |
|---|---|---|
| 1 | **`Validate-CVEs`** | Detects CVEs in current dependencies and proposes fixes |
| 2 | **`Build-Project`** | Runs the build; if errors, generates a fix plan and iterates |
| 3 | **`Consistency-Validation`** | Compares legacy vs new behavior for functional consistency |
| 4 | **`Run-Test`** | Runs unit tests; if any fail, generates a fix plan and iterates |
| 5 | **`Completeness-Validation`** | Catches migration items missed in the initial pass and fixes them |

---

### Exercise 6.1: Upgrade JDK and frameworks (5 minutes)

The JDK upgrade can be launched from either entry point — they run the same task:

- **QUICKSTART → Upgrade Runtime & Frameworks**, or
- **TASKS → Upgrade Tasks → Upgraded Java Runtime**

![Upgrade Runtime](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/upgrade-java-version-visual-studio-code.png)

For our app: select **OpenJDK 21**.

For Spring/third-party upgrades, run **TASKS → Upgrade Tasks → Upgrade Java Framework**.

![Upgrade Java Framework](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/upgrade-framework-version-visual-studio-code.png)

Drive the agent through Continue prompts until the build is green on Java 21 / Spring Boot 3.x.

**✓ Checkpoint:** `pom.xml` shows Java 21 and Spring Boot 3.x; `mvn clean package` succeeds on the new branch.

---

### Exercise 6.2: Run a predefined migration task end-to-end (20 minutes)

We'll use **Secrets and Certificate Management to Azure Key Vault** as the worked example — it is short, visible (the `sa` / `Welcome1234!` literals disappear from source), and complements the database task in Section 7.

1. From the **Issues** tab of the assessment report, locate the credential-migration issue and pick the solution that maps to **Azure Key Vault**.

   ![Run Task from issue](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-visual-studio-code.png)

2. Click **Run Task**.

   ![Run Task confirmation](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/confirm-sql-solution-visual-studio-code.png)

3. The chat panel switches to the `AppModernization` agent. The agent first writes `plan.md` and `progress.md`. **Read the plan**, edit it if the proposed steps don't match your intent, then **type `continue`** (or click Continue).

4. The agent **checks out a new branch**. From here on you are working on a feature branch.

5. **Drive the validation iteration.** Continue at every pause. Watch the tool name in each pause message — it tells you whether you're in CVE check, build fix, consistency, test, or completeness.

6. When the agent emits the **migration summary**, review the diff in the **Source Control** view and select **Keep** to accept.

**✓ Checkpoint:** No `Welcome1234!` in source; the app reads secrets via Azure Key Vault SDK; build green; tests green.

---

### Exercise 6.3: Generate unit tests on the modernized code (5 minutes)

1. In the modernization pane, **TASKS → Quality & Security Tasks → Generate Unit Test Cases**.
2. Drive the agent through Continue prompts.
3. The agent emits a **TestReport** showing test counts and coverage before vs after.

**✓ Checkpoint:** Test count and coverage have measurably increased and `mvn test` is green.

---

## 7. Database Migration: Sybase to Azure SQL

> Reference: [Migrate from Oracle to PostgreSQL by using GitHub Copilot modernization](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-oracle-to-postgresql) (related — explains the coding-notes pattern; not a step-for-step match for Sybase)

### What the predefined tasks actually do here

Read this carefully — it is the most-misunderstood part of the workshop.

The [predefined tasks catalog](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-predefined-tasks) does **not** include a "Sybase → Azure SQL" task. What it offers for our scenario is:

| Predefined task | What it does for Sybase → Azure SQL |
|---|---|
| **Managed Identities for Database migration to Azure** (Azure SQL target) | Replaces the Sybase JDBC driver with `mssql-jdbc`, removes `username`/`password`, wires `authentication=ActiveDirectoryDefault` (Managed Identity) |
| **SQL Dialect: Oracle → PostgreSQL** | **Not applicable** — Sybase ASE is not Oracle |

**T-SQL dialect adjustments** (e.g., `SET ROWCOUNT` → `TOP`, `IDENTITY` syntax, `GETDATE()`) are **largely compatible** between Sybase ASE and Microsoft SQL Server — both are T-SQL family. Any residual conversions are handled by Copilot Chat or by the agent during validation. There is no dialect-conversion predefined task.

> **Coding notes — Oracle-only feature.** The `coding_notes.md` workflow under `.github\<task>\*\results\application_guidance\` is a feature of the Oracle → PostgreSQL task to handle heterogeneous SQL conversion. For Sybase → Azure SQL it is **not required** and the agent does not consume it the same way. Don't create one for this workshop.

---

### Exercise 7.1: Run the database migration task (8 minutes)

1. In the **Issues** tab, find the **database-migration** issue flagging the Sybase ASE driver. The default solution is **Migrate to Azure SQL Database with Managed Identity**.

   ![Database migration issue in report](/images/sybase-migration-task-001.png)

2. Click **Run Task**. The agent generates `plan.md` / `progress.md`, checks out a new branch, and applies driver + auth changes.

3. **Drive the validation iteration** (same 5 tools as Section 6).

**✓ Checkpoint:** `pom.xml` has `mssql-jdbc`, no Sybase driver. `application.properties` has no username/password. Build green.

---

### Exercise 7.2: Verify the diff (2 minutes)

Spot-check the diff in **Source Control**. Common Sybase → Azure SQL conversions you should see (some only if your code triggered them):

| Sybase ASE | Azure SQL Database |
|---|---|
| `com.sybase.jdbc4.jdbc.SybDriver` | `com.microsoft.sqlserver.jdbc.SQLServerDriver` |
| `jdbc:sybase:Tds:host:port/db` | `jdbc:sqlserver://host:1433;database=db;authentication=ActiveDirectoryDefault` |
| `SET ROWCOUNT 3` then query | `SELECT TOP 3 …` |
| String-concatenated SQL | Parameterized `PreparedStatement` / JPA |
| Hardcoded `sa` / `Welcome1234!` | Removed; auth via Managed Identity |

Confirm the new `application.properties`:

```properties
spring.datasource.url=jdbc:sqlserver://${SQL_SERVER}.database.windows.net:1433;database=${SQL_DB};authentication=ActiveDirectoryDefault;encrypt=true;trustServerCertificate=false
spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.SQLServerDialect
```

No `username` / `password`. Auth flows through `ActiveDirectoryDefault` (Managed Identity in Azure, developer credentials locally via `az login`).

**✓ Checkpoint:** Driver swapped, credentials gone, Managed Identity wired.

---

## 8. Verify the Modernized Application (Stretch)

> *Stretch — skip if you are at the 90-minute mark.*

Sections 8–9 are **verification of what the agent already produced** during Section 6, not parallel manual work. Use them only if you finish early.

### 8.1: Smoke-test the REST endpoints (10 minutes)

The modernization tasks should have produced a Spring Boot application with REST endpoints. Run it and exercise the API:

```bash
mvn spring-boot:run
```

```bash
# Get all users
curl http://localhost:8080/api/users

# Create a user
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{"username":"johndoe","firstname":"John","lastname":"Doe","email":"john@example.com"}'

# Get / update / delete by id
curl http://localhost:8080/api/users/1
curl -X DELETE http://localhost:8080/api/users/1
```

If endpoints don't exist yet, ask Copilot Chat:

```text
@workspace Did the AppModernization agent generate REST controllers for User CRUD? If not, where is User exposed today?
```

### 8.2: Run the generated tests

```bash
mvn test
```

Open the **TestReport** generated by **Generate Unit Test Cases** (Section 6.5) and confirm coverage moved.

---

## 9. Cloud Deployment (Stretch)

> *Stretch — typically not feasible in the 90-minute window.*

The `AppModernization` agent can also generate Azure deployment artifacts (Dockerfile, `azure.yaml`, Bicep). To deploy:

1. Inspect the generated `Dockerfile` (run **Containerization** during a Custom Assessment if it isn't there yet).
2. Install **Azure Developer CLI**: `winget install Microsoft.AzureDeveloperCLI`.
3. `azd auth login`, then `azd up` from the project root.

The CLI provisions resource group, Azure SQL, Container Apps (or App Service), Managed Identity, and Key Vault according to the generated infrastructure.

Full reference: [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/).

---

## 10. Best Practices and Wrap-up

### Driving the agent well

- **Read every pause message** before clicking Continue — it names the tool that's about to run.
- **Don't change the model** while the agent is running. Let it stay on Claude Sonnet 4.5.
- **Trust `plan.md`, but verify** — edit it before the first Continue if a step looks wrong.
- **One task at a time.** Finish the validation iteration before starting the next predefined task.
- **Use Source Control diff view** after each task to see what changed.

### When to fall back to Copilot Chat

- The right predefined task doesn't exist for your scenario.
- You need a one-line tweak after the agent finishes.
- You want to *understand* the diff before clicking Keep.

### What you accomplished today

- Ran an assessment against a legacy Servlet/JSP + Sybase ASE app.
- Interpreted the report across cloud-readiness, java-upgrade, and security domains.
- Ran at least one **predefined migration task** end-to-end with the 5-tool validation iteration.
- Removed hardcoded credentials and switched the database to Azure SQL with Managed Identity.
- Generated additional unit tests on the modernized code.

### Continue learning

- Full predefined task catalog: [Predefined tasks](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-predefined-tasks)
- End-to-end docs: [GitHub Copilot modernization for Java overview](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java)
- Portfolio integration: [Azure Migrate / Dr. Migrate handoff](https://learn.microsoft.com/en-us/azure/developer/java/migration/github-copilot-app-modernization-for-java-portfolio-assessment-integration)
- Spring Boot reference: [Spring Boot docs](https://spring.io/projects/spring-boot)

### Feedback

- What was clear? What was confusing?
- Which predefined task would you run next on your own codebase?

**Thank you for participating!**
