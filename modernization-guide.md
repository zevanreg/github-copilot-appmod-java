# Step-by-Step Modernization Guide

## Using GitHub Copilot App Modernization for Java

**Duration:** 90 minutes (guided exercises)  
**Prerequisites:** Completed [Pre-requisites](./hackathon-prerequisites.md) and reviewed [App Background](./legacy-app-background.md)

---

## Table of Contents

1. [Getting Started with GitHub Copilot](#1-getting-started-with-github-copilot)
2. [Opening and Understanding the Legacy Application](#2-opening-and-understanding-the-legacy-application)
3. [Using GitHub Copilot App Modernization Extension](#3-using-github-copilot-app-modernization-extension)
4. [Running Assessment and Analysis](#4-running-assessment-and-analysis)
5. [Understanding Assessment Results](#5-understanding-assessment-results)
6. [Plan and Apply Migration Tasks](#6-plan-and-apply-migration-tasks)
7. [Database Migration: Sybase to Azure SQL](#7-database-migration-sybase-to-azure-sql)
8. [Building REST APIs](#8-building-rest-apis)
9. [Testing and Validation](#9-testing-and-validation)
10. [Preparing for Cloud Deployment](#10-preparing-for-cloud-deployment)
11. [Best Practices and Tips](#11-best-practices-and-tips)

---

## 1. Getting Started with GitHub Copilot

### What is GitHub Copilot?

GitHub Copilot is an **AI pair programmer** that helps you write code faster and smarter. It uses AI models trained on billions of lines of public code to suggest:
- Complete functions
- Code snippets
- Tests
- Documentation
- Entire files

### Using Claude Sonnet 4.6 (Recommended)

For this hackathon, we **strongly recommend** using **Claude Sonnet 4.6** as your Copilot model for superior Java modernization assistance.

**Quick Verification:**
1. Open Copilot Chat panel (click chat icon in Activity Bar or press `Ctrl + Alt + I`)
2. Check the model dropdown at the top of the chat panel
3. It should show **"Claude Sonnet 4.6"** or **"Claude 3.7 Sonnet"**
4. If not, refer to the [Prerequisites guide](./hackathon-prerequisites.md#43-select-claude-sonnet-46-as-your-model-recommended) for setup steps

**Why Claude Sonnet 4.6 for this hackathon?**
- Excellent at understanding legacy Java patterns
- Superior Spring Boot code generation
- Better modernization strategy recommendations
- More accurate assessment analysis
- Clearer explanations of complex migrations

### How GitHub Copilot Works

**Input:** You provide context through:
- Comments describing what you want
- Function signatures
- Existing code in your file
- Open files in your workspace

**Output:** Copilot suggests:
- Gray "ghost text" as you type
- Multiple suggestions you can cycle through
- Code completions

### Basic Copilot Keyboard Shortcuts

| Action                      | Windows/Linux    | macOS           |
|-----------------------------|------------------|-----------------|
| Accept suggestion           | `Tab`            | `Tab`           |
| Dismiss suggestion          | `Esc`            | `Esc`           |
| Show next suggestion        | `Alt + ]`        | `Option + ]`    |
| Show previous suggestion    | `Alt + [`        | `Option + [`    |
| Trigger suggestion manually | `Alt + \`        | `Option + \`    |
| Open Copilot chat           | `Ctrl + Alt + I` | `Cmd + Alt + I` |

---

### Exercise 1.0: Verify Claude Sonnet 4.6 (2 minutes)

Before we begin, let's confirm you're using the recommended model.

1. **Open Copilot Chat:**
   - Click the chat icon in the Activity Bar (left side)
   - OR press `Ctrl + Alt + I` (Windows/Linux) or `Cmd + Alt + I` (macOS)

2. **Check the model:**
   - Look at the model dropdown at the top of the chat panel
   - Should display: **"Claude Sonnet 4.6"** or similar

3. **Verify with a question:**
   ```
   What model are you using?
   ```
   - Copilot should confirm it's using Claude Sonnet 4.6

4. **If wrong model is selected:**
   - Click the model dropdown
   - Select "Claude Sonnet 4.6" from the list
   - If not available, see [Prerequisites](./hackathon-prerequisites.md#43-select-claude-sonnet-46-as-your-model-recommended)

**✓ Checkpoint:** Claude Sonnet 4.6 is selected and verified.

---

### Exercise 1.1: Test GitHub Copilot (5 minutes)

Let's verify Copilot is working before we start modernization.

1. **Create a new Java file for testing:**
   - In VS Code, create a new file: `File > New File`
   - Save it as `CopilotTest.java` in the `app/src/main/java/com/example` folder

2. **Write a comment to trigger Copilot:**
   ```java
   // Function to calculate the factorial of a number recursively
   ```

3. **Press Enter and wait 1-2 seconds**
   - You should see gray "ghost text" appear
   - This is Copilot's suggestion

4. **Accept the suggestion:**
   - Press `Tab` to accept
   - Copilot should generate the factorial function

5. **Try another example:**
   ```java
   // Function to check if a string is a palindrome
   ```

6. **See alternative suggestions:**
   - Start typing: `public boolean isPalindrome(`
   - Press `Alt + ]` (Windows/Linux) or `Option + ]` (macOS) to cycle through alternatives

**Expected Result:** You see code suggestions appearing and can accept them with Tab.

**✓ Checkpoint:** If Copilot is not working, check:
- Status bar icon (bottom-right) shows Copilot is active
- You're signed in to GitHub in VS Code
- Internet connection is stable

**Delete `CopilotTest.java` when done - we don't need it.**

---

### Exercise 1.2: Using GitHub Copilot Chat (5 minutes)

Copilot Chat lets you have a conversation with AI about your code.

1. **Open Copilot Chat:**
   - Press `Ctrl + I` (Windows/Linux) or `Cmd + I` (macOS)
   - OR click the chat icon in the Activity Bar (left side)

2. **Ask a question about Java:**
   ```
   What are the benefits of Spring Boot over traditional Java servlets?
   ```

3. **Review the response:**
   - Copilot explains Spring Boot advantages
   - This helps understand what we'll be doing in modernization

4. **Ask about your workspace:**
   ```
   @workspace Explain the structure of this Java application
   ```
   
   The `@workspace` prefix tells Copilot to analyze your entire workspace.

5. **Ask for code explanation:**
   - Open `app/src/main/java/com/example/servlet/UserServlet.java`
   - Select the `doGet` method (lines 19-35)
   - Right-click > "Copilot" > "Explain This"
   - OR press `Ctrl + I` and type `/explain`

**✓ Checkpoint:** You can chat with Copilot and ask questions about code.

---

## 2. Opening and Understanding the Legacy Application

### Exercise 2.1: Open the Project (3 minutes)

1. **Open the workspace in VS Code:**
   ```bash
   cd c:\github\github-copilot-appmod-java
   code .
   ```
   
   OR in VS Code: `File > Open Folder > Select 'github-copilot-appmod-java'`

2. **Trust the workspace:**
   - If prompted, click "Yes, I trust the authors"
   - This enables full VS Code features

3. **Wait for Java Language Server to initialize:**
   - Look for "Java: Ready" in the status bar (bottom)
   - This may take 30-60 seconds on first open

4. **Open integrated terminal:**
   - Press `` Ctrl + ` `` (backtick) or `Terminal > New Terminal`
   - Navigate to app directory: `cd app`

---

### Exercise 2.2: Build the Legacy Application (5 minutes)

1. **Run Maven compile:**
   ```bash
   mvn clean compile
   ```

2. **Expected output:**
   ```
   [INFO] BUILD SUCCESS
   [INFO] Total time: 10.5 s
   ```

3. **If build fails:**
   - Check Java version: `java -version` (should be 11+)
   - Check Maven version: `mvn -version` (should be 3.6+)
   - Delete target folder: `rm -r target` and retry

4. **Package the application:**
   ```bash
   mvn clean package
   ```

5. **Verify WAR file created:**
   ```bash
   ls target/sybase-web-app.war
   ```

**✓ Checkpoint:** Application compiles successfully with no errors.

---

### Exercise 2.3: Explore the Codebase with Copilot (10 minutes)

Use Copilot to understand the application faster.

**Codebase at a Glance:**
- **~800 lines** of application code (472 Java, 281 JSP, 46 SQL)
- **7 Java files** (servlets, DAOs, models, utilities)
- **3 JSP view files** (server-side rendered UI)
- **2 SQL files** (schema and stored procedures)

1. **Open Copilot Chat panel** (if not already open)

2. **Ask about the overall structure:**
   ```
   @workspace Provide a summary of this Java web application including its architecture, technologies used, and main components
   ```

3. **Ask about specific files:**
   ```
   @workspace What does UserServlet.java do? Explain its responsibilities and methods.
   ```

4. **Identify modernization candidates:**
   ```
   @workspace What parts of this application use outdated or legacy patterns that should be modernized?
   ```

5. **Ask about dependencies:**
   ```
   @workspace Analyze the pom.xml file and identify which dependencies are outdated or should be replaced in a modern application
   ```

6. **Document your findings:**
   - Create a new file: `modernization-notes.md`
   - Use Copilot to help document:
   ```
   # Modernization Notes
   
   ## Current State
   // Ask Copilot to fill this in based on workspace analysis
   
   ## Issues Identified
   // List issues found
   
   ## Modernization Goals
   // What we want to achieve
   ```

**💡 Tip:** Use `@workspace` to give Copilot context about your entire project, not just the current file.

---

## 3. Using GitHub Copilot App Modernization Extension

### What is GitHub Copilot App Modernization for Java?

This extension provides specialized capabilities for Java application modernization:

- **Automated Assessment:** Scans your codebase for modernization opportunities
- **Migration Guidance:** Suggests patterns and frameworks
- **Code Generation:** Generates Spring Boot equivalents
- **Best Practices:** Applies modern Java patterns
- **Azure Integration:** Prepares apps for cloud deployment

---

### Exercise 3.1: Access the Extension (3 minutes)

1. **Verify extension is installed:**
   - Press `Ctrl + Shift + X` to open Extensions view
   - Search for "App Modernization" or "Migrate Java to Azure"
   - Should show "GitHub Copilot App Modernization for Java" as installed

2. **Open the extension panel:**
   - Look for the App Modernization icon in the Activity Bar (left side)
   - It looks like a migration/transformation icon
   - Click to open the panel

3. **Alternative access:**
   - Press `Ctrl + Shift + P` (Command Palette)
   - Type "App Modernization"
   - See available commands

**✓ Checkpoint:** Extension panel is visible and accessible.

---

### Exercise 3.2: Configure Extension Settings (3 minutes)

1. **Open Settings:**
   - `File > Preferences > Settings` (Windows/Linux)
   - `Code > Preferences > Settings` (macOS)
   - OR press `Ctrl + ,`

2. **Search for "App Modernization" or "Java Migrate"**

3. **Key settings to verify/configure:**
   - **Target Framework:** Spring Boot
   - **Target Java Version:** Java 17 or Java 21
   - **Target Database:** Azure SQL Database
   - **Assessment Level:** Full (for comprehensive analysis)

4. **Azure settings (optional for deployment):**
   - Sign in to Azure (if you have subscription)
   - Select target subscription
   - Select target region (e.g., East US)

**Note:** For hackathon, we'll focus on modernization first. Azure deployment is optional based on time.

---

## 4. Running Assessment and Analysis

> Reference: [Working with assessment - GitHub Copilot Modernization for Java](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-working-with-assessment?pivots=vscode)

Application assessment is the critical first step in your modernization journey. The GitHub Copilot modernization extension provides two ways to start an assessment, supports multiple reports per run (each run produces an independent report you can compare over time), and lets you import, export, and delete reports.

**Two ways to start an assessment:**

- **Recommended assessment** — quickly start without manual configuration by selecting from preconfigured domains.
- **Custom assessment** — fine-grained control over assessment configuration for tailored analysis.

---

### Exercise 4.1: Run a Recommended Assessment (5 minutes)

Use a recommended assessment for the fastest path to results.

1. **Open the GitHub Copilot modernization pane** from the VS Code sidebar.

2. **Start the assessment:**
   - In the **QUICKSTART** section, select **Start Assessment** or **Open Assessment Dashboard**.

   ![Start Assessment](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/run-assessment-visual-studio-code.png)

3. **Select Recommended Assessment.**

4. **Choose the domains** you want to assess from the recommended options. Each domain represents a common migration scenario with preconfigured settings.

   ![Recommended Assessment](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/recommended-assessment.png)

5. **Select OK** to start the assessment.

6. **Wait for the assessment to complete.** When the analysis finishes, the modernization assessor opens the **Assessment Report** automatically and adds a new report entry to the report list.

**✓ Checkpoint:** A new assessment report is generated and visible in the report list.

---

### Exercise 4.2: Run a Custom Assessment (Optional, 5 minutes)

Use a custom assessment when you need to target specific domains, analysis coverage, runtime, or Azure compute targets.

1. In the **QUICKSTART** section, select **Start Assessment** or **Open Assessment Dashboard**.

2. Select **Custom Assessment**.

   ![Custom Assessment](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/custom-assessment.png)

3. **Configure the assessment properties** as described below, then select **Run**.

   ![Custom Assessment Properties](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/custom-assessment-properties.png)

#### Configuration properties

**General: Assessment Domains**

| Domain          | Description                                                                           |
|-----------------|---------------------------------------------------------------------------------------|
| Java Upgrade    | Identify outdated app stacks and get upgrade recommendations.                         |
| Cloud Readiness | Assess your app's readiness for Azure, with actionable migration guidance.            |
| Security        | Scan your code for security issues using ISO 5055 guidelines, with recommended fixes. |

**General: Analysis Coverage**

| Coverage                            | Description                                                 |
|-------------------------------------|-------------------------------------------------------------|
| Issue only                          | Analyze source code to detect issues.                       |
| Issues & Technologies               | Detect issues and identify used technologies.               |
| Issues, Technologies & Dependencies | Detect issues, identify technologies, and map dependencies. |

**Java Upgrade: Target Runtime** (when Java Upgrade is selected): OpenJDK 21 (recommended), OpenJDK 17, or OpenJDK 11.

**Cloud Readiness: Target Compute Services** (when Cloud Readiness is selected): Azure App Service, Azure Kubernetes Service (AKS), or Azure Container Apps (ACA). Choose multiple targets to compare them in the assessment report.

**Cloud Readiness: Target Operating System**: Linux or Windows.

**Cloud Readiness: Containerization**: Enable to analyze problems that need to be fixed to containerize your app.

#### Example configurations

- **Migrate to AKS as Linux containers:** Cloud Readiness + Issue only + AKS + Linux + Enable Containerization.
- **Migrate to App Service Linux:** Cloud Readiness + Issue only + Azure App Service + Linux.
- **Modernize to JDK 21:** Java Upgrade + Issue only + OpenJDK 21.

After the assessment completes, an interactive dashboard opens. When you configure multiple Azure service targets, you can switch between them to compare migration approaches.

![Azure Service Target selection](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/list-azure-service-target-for-assessment-report-visual-studio-code.png)

**For this hackathon:** Run a Recommended Assessment with **Cloud Readiness** and **Java Upgrade** domains so you can see issues for both modernization and Azure migration.

---

### Exercise 4.3: Manage Assessment Reports (3 minutes)

Each assessment run generates an independent report. You can import, export, and delete reports from the report list.

1. **Import a report** — In the assessment reports page, select **Import**, or press `Ctrl + Shift + P` and search for *Import assessment report*. Reports can come from AppCAT CLI (`report.json`), an exported GitHub Copilot modernization report, or a Dr. Migrate app context file.

   ![Import assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/import-assessment-report-visual-studio-code.png)

2. **Export a report** — In the report list, select the **...** (more actions) button on the target report and select **Export**. Share the exported report so others can import it without rerunning the assessment.

   ![Export assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/export-assessment-report-visual-studio-code.png)

3. **Delete a report** — In the report list, select **...** > **Delete** on the report you no longer need.

   ![Delete assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/delete-assessment-report-visual-studio-code.png)

**✓ Checkpoint:** You know how to run, view, import, export, and delete assessment reports.

---

## 5. Understanding Assessment Results

> Reference: [Understand assessment coverage by GitHub Copilot modernization](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-assess-rules) · [Interpret the assessment report](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-working-with-assessment?pivots=vscode#interpret-the-assessment-report)

The assessment detects issues across **three domains**, surfaces the **dependencies** and **technologies** in use, and produces a categorized, prioritized report so you can plan your migration confidently.

---

### Exercise 5.1: Tour the Assessment Report (5 minutes)

The assessment report consists of:

- **Application Information** — Java version, frameworks, build tools, and project structure.
- **Issue Summary** — Issues categorized by domain with criticality percentages.
- **Detailed Analysis** — Four tabs: Issues, Dependencies, Technologies, Insights.

![Assessment report dashboard](/images/assessment-report-summary.png)

#### Issues tab

Categorized list of issues across Cloud Readiness, Java Upgrade, and Security that you need to address to migrate the application.

**Criticality:**

| Level     | Meaning                                                     |
|-----------|-------------------------------------------------------------|
| Mandatory | Issues that you must fix for migration to Azure.            |
| Potential | Issues that might impact migration and need review.         |
| Optional  | Low-impact issues. Fixing them is recommended but optional. |

![Issue list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-issue-list-visual-studio-code.png)

Expand any issue to see:

- A list of files where the incidents occurred (with line counts).
- A detailed description of the problem, known solutions, and supporting documentation.

![Issue detail](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-issue-detail-visual-studio-code.png)

#### Dependencies tab

Lists all Java-packaged dependencies found in the application.

![Dependency list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-dependency-list-visual-studio-code.png)

#### Technologies tab

Embedded libraries grouped by function — gives you a quick understanding of what the application does.

![Technology list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-technology-list-visual-studio-code.png)

#### Insights tab

File details and information that help you understand the detected technologies.

![Insight list](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-insight-list-visual-studio-code.png)

---

### Exercise 5.2: Issue Coverage by Domain (10 minutes)

The assessment detects issues across three domains. Cross-reference the rules below with what you see in your report.

#### Domain: cloud-readiness

Identifies portability, scalability, and statelessness concerns that block successful Azure migration.

| Rule                        | What it detects                                                                                                                                               |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| credential-migration        | Hardcoded cloud credentials and embedded secret-management libraries.                                                                                         |
| region-configuration        | Hardcoded cloud region identifiers in code or config.                                                                                                         |
| storage-migration           | Vendor object-storage SDK usage (AWS S3, GCS) that doesn't map to native Azure storage.                                                                       |
| messaging-service-migration | Dependencies and connection strings for SQS/SNS, Kafka, RabbitMQ, ActiveMQ, IBM MQ, Pub/Sub, etc.                                                             |
| **database-migration**      | Connection strings, drivers, and timeouts for MongoDB, MySQL, PostgreSQL, MSSQL, Cassandra, MariaDB, Oracle, Db2, **Sybase ASE**, Firebird, SQLite, and more. |
| file-system-management      | Local filesystem reads/writes that break in ephemeral cloud containers.                                                                                       |
| local-credential            | `.jks` keystore files and clear-text passwords in property/XML files.                                                                                         |
| configuration-management    | OS-specific or local-file configuration that doesn't scale.                                                                                                   |
| session-management          | `HttpSession` state and the `distributable` web descriptor tag.                                                                                               |
| remote-communication        | CORBA, RMI, JCA, unsecured HTTP/FTP, raw sockets, hardcoded URLs.                                                                                             |
| jakarta-migration           | Jakarta/Java EE APIs and proprietary JBoss/WebLogic/WebSphere artifacts.                                                                                      |
| containerization            | Missing Dockerfile or problematic Dockerfile instructions.                                                                                                    |
| scheduled-job-migration     | AWS Lambda handlers, GCP Functions, Quartz, Spring Batch — needs cloud event-driven refactor.                                                                 |
| apm-migration               | Embedded New Relic / Elastic APM / Dynatrace agents.                                                                                                          |
| auth-migration              | SAML, OAuth 2.0, OpenID, Spring Security, LDAP, legacy webform auth.                                                                                          |
| os-compatibility            | Windows-specific `.dll` dependencies that don't run on Linux containers.                                                                                      |

**For our app:** the **database-migration** rule will flag the Sybase ASE driver — a key issue for our Sybase → Azure SQL move.

#### Domain: java-upgrade

| Rule                 | What it detects                                                                                                  |
|----------------------|------------------------------------------------------------------------------------------------------------------|
| java-version-upgrade | Non-LTS Java versions (9, 10, 12–16, 19, 20) and legacy versions (1.x–8, 11).                                    |
| framework-upgrade    | Spring Boot, Spring Cloud, Spring Framework, Jakarta EE versions past end-of-OSS-support.                        |
| deprecated-apis      | Hundreds of removed/deprecated APIs (`sun.misc.BASE64`, `Thread.stop`, JBoss/Seam/WebLogic/WebSphere internals). |
| build-tool           | Legacy build systems like Ant (`build.xml`) or Eclipse-specific WTP/JEM project natures.                         |

**For our app:** **java-version-upgrade** will flag Java 8 (legacy) and **build-tool** may flag any legacy patterns.

#### Domain: Security (ISO 5055 guided)

The Security domain detects 42 security weaknesses curated from the [ISO/IEC 5055](https://www.it-cisq.org/standards/code-quality-standards/) standard — designed to "find and prevent the 8% of flaws that cause 90% of production issues."

Highlights you are likely to see in this codebase:

| CWE                                             | Title                                                    |
|-------------------------------------------------|----------------------------------------------------------|
| CWE-89                                          | SQL Injection                                            |
| CWE-564                                         | SQL Injection: Hibernate                                 |
| CWE-79                                          | Cross-site Scripting                                     |
| CWE-22 / CWE-23 / CWE-36                        | Path Traversal variants                                  |
| CWE-77 / CWE-78 / CWE-88                        | Command and Argument Injection                           |
| CWE-90 / CWE-91 / CWE-643 / CWE-652             | LDAP / XML / XPath / XQuery Injection                    |
| CWE-259 / CWE-321 / CWE-798                     | Hard-coded password / cryptographic key / credentials    |
| CWE-434                                         | Unrestricted Upload of File with Dangerous Type          |
| CWE-456 / CWE-457 / CWE-665                     | Missing/improper variable or resource initialization     |
| CWE-477                                         | Use of Obsolete Function                                 |
| CWE-502                                         | Deserialization of Untrusted Data                        |
| CWE-543 / CWE-567 / CWE-662 / CWE-820 / CWE-821 | Synchronization & multithreading issues                  |
| CWE-611                                         | Improper Restriction of XML External Entity Reference    |
| CWE-732                                         | Incorrect Permission Assignment for Critical Resource    |
| CWE-772 / CWE-775                               | Missing Release of Resource / File Descriptor            |
| CWE-778                                         | Insufficient Logging                                     |
| CWE-835                                         | Loop with Unreachable Exit Condition (infinite loop)     |
| CWE-1057                                        | Data access bypassing the central data manager component |

**For our app:** expect **CWE-798 / CWE-259** to flag the hardcoded `sa` / `Welcome1234!` credentials in `DatabaseConnection.java`, and **CWE-89** to flag any string-concatenated SQL in `UserDAO.java`.

---

### Exercise 5.3: Prioritize Modernization Tasks (5 minutes)

Use the report's criticality and domain breakdown to build a roadmap.

1. **Open Copilot Chat** and ask:

   ```text
   Based on the assessment results for this Java application, create a prioritized modernization roadmap with tasks ordered by criticality and dependencies.
   ```

2. **Suggested ordering**:

   **Phase 1 — Mandatory (blocker)**: hardcoded credentials, Java 8 upgrade, Sybase driver, missing Dockerfile.

   **Phase 2 — Potential (high impact)**: Servlet → Spring Boot, JSP → REST + Thymeleaf, externalized configuration.

   **Phase 3 — Optional (improvements)**: API documentation, observability, advanced security hardening.

3. **Save the roadmap** as `modernization-roadmap.md` to track progress.

**✓ Checkpoint:** You can map issues in the report to the rules above and have a prioritized plan.

---

## 6. Plan and Apply Migration Tasks

> Reference: [Quickstart: Assess and migrate a Java project using GitHub Copilot modernization](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-quickstart-assess-migrate?pivots=vscode)

GitHub Copilot modernization ships with **predefined tasks** for the most common migration scenarios — from upgrading the JDK and frameworks to replacing database clients with Managed Identity authentication. The recommended workflow is:

1. **Upgrade JDK and dependency versions** (TASKS – Upgrade Tasks).
2. **Run an assessment** (Section 4) and review the report (Section 5).
3. **Run a predefined migration task** from the report.
4. **Drive the validation iteration** until the build, tests, and consistency checks pass.
5. **Generate unit tests** (Quality & Security Tasks).

> In Visual Studio Code, GitHub Copilot modernization uses the `AppModernization` custom agent with **Claude Sonnet 4.5** by default, falling back to `auto` if not available. You can switch models from the chat language-model picker.

---

### Exercise 6.1: Choose a Modernization Strategy (3 minutes)

Three common approaches:

- **Big Bang (full rewrite):** clean slate, highest risk — best for small apps.
- **Strangler Fig (incremental):** gradually replace old code — best for large production systems.
- **Hybrid (lift and modernize):** keep structure, upgrade technologies — best for time-boxed migrations and POCs.

**For this hackathon we use the Hybrid strategy:** keep the `User` model and business logic, replace Servlet with Spring Boot, replace JDBC `UserDAO` with Spring Data JPA, upgrade to Java 17/21, and externalize configuration.

**Success criteria:**

- All CRUD operations work via REST endpoints.
- No hardcoded credentials anywhere in source.
- Java 17+ on Spring Boot 3.x.
- Build green: `mvn clean test`.
- Application starts in < 10 seconds; API responses < 500 ms.

---

### Exercise 6.2: Upgrade JDK and Frameworks (5 minutes)

You can upgrade the JDK in two equivalent ways from the **GitHub Copilot modernization** pane:

- **QUICKSTART → Upgrade Runtime & Frameworks**
- **TASKS – Upgrade Tasks → Upgraded Java Runtime**

![Upgrade Runtime](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/upgrade-java-version-visual-studio-code.png)

To upgrade the Spring framework or any third-party dependency, run the **Upgrade Java Framework** task in **TASKS – Upgrade Tasks**.

![Upgrade Java Framework](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/upgrade-framework-version-visual-studio-code.png)

For our app:

- Upgrade JDK to **OpenJDK 21** (or 17 LTS).
- Upgrade to **Spring Boot 3.x** so we can use Jakarta namespaces, Spring Data JPA, and modern Tomcat.

---

### Exercise 6.3: Apply a Predefined Migration Task (15 minutes)

After the assessment finishes (Section 4), the report shows issues with **suggested solutions** you can run as predefined tasks.

1. **Open the Assessment Report** and locate a relevant issue, for example:
   - *Servlet container migration*
   - *Database Migration (Sybase / Microsoft SQL)*
   - *Credential management — replace local credentials with Managed Identity*

   ![Assessment report with task](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/assessment-report-visual-studio-code.png)

2. **Pick a solution** from the issue's solution list and select **Run Task**.

   ![Run Task](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/confirm-sql-solution-visual-studio-code.png)

3. **Copilot Chat opens in Agent Mode.** The agent first generates two files:
   - `plan.md` — the proposed migration plan. Review and edit if needed.
   - `progress.md` — a live progress tracker.

4. **Type `continue`** in chat to confirm and start the migration.

5. **Version control checkpoint** — before any code changes, the agent checks the VCS status and **checks out a new branch** for the migration.

6. **Tool confirmations** — the agent invokes various GitHub Copilot modernization tools. Repeatedly select or enter **Continue** to confirm each tool/command and let the code changes complete.

**Why predefined tasks beat ad-hoc prompting:**

- They orchestrate plan → branch → code → validate → fix.
- They emit structured plans you can review (`plan.md` / `progress.md`).
- They work hand-in-hand with the validation iteration below.

---

### Exercise 6.4: Validation Iteration (10 minutes)

After the agent finishes the initial code changes, type `continue` to enter the **validation and fix iteration loop**. The loop runs five tools in sequence:

1. **`Validate-CVEs`** — detects Common Vulnerabilities and Exposures in current dependencies and fixes them.
2. **`Build-Project`** — attempts to resolve any build errors.
3. **`Consistency-Validation`** — analyzes the code for functional consistency with the legacy behavior.
4. **`Run-Test`** — runs unit tests, generates a fix plan for failures, and iterates until tests pass.
5. **`Completeness-Validation`** — catches migration items missed in the initial pass and fixes them.

Once all tools complete, type `continue` once more to **generate the migration summary**. Review the diff and select **Keep** to accept the changes.

**✓ Checkpoint:** Code is migrated, build is green, tests pass, and the migration summary is generated.

---

### Exercise 6.5: Generate Unit Test Cases (5 minutes)

Use the dedicated task to expand test coverage on the modernized code.

1. Open the **GitHub Copilot modernization** pane.
2. In **TASKS** → **Quality & Security Tasks**, select **Generate Unit Test Cases**.
3. The agent generates unit tests and produces a **TestReport** showing test results before and after generation.

**✓ Checkpoint:** You have additional generated unit tests with a measurable coverage delta.

---

## 7. Database Migration: Sybase to Azure SQL

> Reference: [Migrate from Oracle to PostgreSQL by using GitHub Copilot modernization](https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-github-copilot-app-modernization-for-java-oracle-to-postgresql) (the same task pattern applies for Sybase → Azure SQL homogeneous-style migration)

GitHub Copilot modernization provides a list of predefined tasks for **database migration scenarios**, including a dedicated **Microsoft SQL Server** task. The task focuses on:

- **Database client update** — replace username/password with **Azure Managed Identity** authentication.
- **SQL conversion** — adjust SQL dialect from Sybase ASE to Azure SQL (Microsoft SQL Server).

Sybase ASE and Microsoft SQL Server share **Transact-SQL (T-SQL) heritage**, so most syntax is compatible — but you still need to address vendor-specific constructs (e.g., `SET ROWCOUNT`, `IDENTITY` syntax, `GETDATE()` defaults, `DATETIME` vs `DATETIME2`, isolation hints, `sp_*` system procedures).

> **Heterogeneous-style hint:** the Oracle → PostgreSQL workflow uses **coding notes** (`coding_notes.md`) to drive a more accurate SQL conversion. For Sybase → Azure SQL the conversion is mostly homogeneous T-SQL, so coding notes are typically not required — but you can still drop a `coding_notes.md` into `.github\<migration>\*\results\application_guidance\` to give the agent project-specific schema hints.

---

### Exercise 7.1: Run the Sybase → Azure SQL Migration Task (15 minutes)

1. **Run the application assessment** (see Section 4) with the **Cloud Readiness** domain selected, so the **database-migration** rule fires for the Sybase ASE driver.

2. **Review the assessment report.** Because the codebase uses Sybase, the report surfaces a **Database Migration (Microsoft SQL)** issue with a default solution to migrate the database client to **Azure SQL Database with Managed Identity**.

   ![Database migration issue in report](/images/sybase-migration-task-001.png)

3. **(Optional) Place coding notes.** If you have schema-conversion guidance from a DBA or from a database-migration tool, save it as `coding_notes.md` under:

   ```text
   .github\<migration-task-folder>\*\results\application_guidance\coding_notes.md
   ```

   Coding notes can include:
   - Data type mappings and structural changes.
   - Conversion details for sequences, identities, and composite types.
   - Adjustments to date/time or interval implementations.
   - References to tables with referential integrity constraints.
   - Summaries of complex stored procedures and function signatures.
   - Additional AI-generated hints to improve translation accuracy.

4. **Select Run Task** on the issue. If `coding_notes.md` is present, the agent uses it to produce a higher-quality SQL conversion alongside the database client update with Managed Identity authentication. Otherwise it applies general **Sybase ASE → Microsoft SQL / Azure SQL** syntax adjustments.

   ![Migration task execution](https://learn.microsoft.com/en-us/azure/developer/java/migration/media/migrate-github-copilot-app-modernization-for-java/oracle-postgresql-coding-notes.png)

5. **Drive the validation iteration** (Section 6.4): `Validate-CVEs` → `Build-Project` → `Consistency-Validation` → `Run-Test` → `Completeness-Validation`.

**✓ Checkpoint:** The Sybase JDBC driver and credentials are replaced with the **mssql-jdbc** driver and **DefaultAzureCredential** / Managed Identity, and the build/tests are green.

---

### Exercise 7.2: Verify Sybase-Specific SQL Was Converted (5 minutes)

Spot-check the most common Sybase → Azure SQL conversions in the diff:

| Sybase ASE                        | Azure SQL Database                                                             |
|-----------------------------------|--------------------------------------------------------------------------------|
| `SET ROWCOUNT 3` then query       | `SELECT TOP 3 ...`                                                             |
| `id INT IDENTITY`                 | `id INT IDENTITY(1,1)`                                                         |
| `DATETIME DEFAULT GETDATE()`      | `DATETIME2 DEFAULT SYSUTCDATETIME()`                                           |
| `sp_*` Sybase system procedures   | Azure SQL DMV equivalents (e.g., `sys.dm_*`)                                   |
| `String.format` SQL concatenation | Parameterized `PreparedStatement` / JPA                                        |
| `com.sybase.jdbc4.jdbc.SybDriver` | `com.microsoft.sqlserver.jdbc.SQLServerDriver`                                 |
| `jdbc:sybase:Tds:host:port/db`    | `jdbc:sqlserver://host:1433;database=db;authentication=ActiveDirectoryDefault` |

**Tip:** With Spring Data JPA you can replace `SET ROWCOUNT 3` with a method-name query:

```java
List<User> findTop3ByOrderByIdAsc();
```

JPA generates the right `TOP` / `LIMIT` syntax for the active dialect — no more database-specific SQL.

---

### Exercise 7.3: Confirm Managed Identity Wiring (5 minutes)

Check `application.properties` (or `application.yml`):

```properties
spring.datasource.url=jdbc:sqlserver://${SQL_SERVER}.database.windows.net:1433;database=${SQL_DB};authentication=ActiveDirectoryDefault;encrypt=true;trustServerCertificate=false
spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.SQLServerDialect
```

Notice:

- **No `username` / `password`** — auth flows through Managed Identity (`ActiveDirectoryDefault`).
- The `mssql-jdbc` driver replaces the Sybase driver in `pom.xml`.
- For local development you can keep an H2 (`MODE=MSSQLServer`) profile, while production resolves credentials via the Azure Identity SDK.

**✓ Checkpoint:** No credentials in source, the app binds to Azure SQL via Managed Identity, and Sybase-specific SQL has been converted.

---

## 8. Building REST APIs

### Exercise 8.1: Test REST Endpoints (10 minutes)

Let's verify our new REST API works.

1. **Start the application:**

   ```bash
   mvn spring-boot:run
   ```

2. **Wait for startup:**

   ```text
   Started Application in 3.254 seconds
   ```

3. **Test with curl (or Postman):**

   **Get all users:**

   ```bash
   curl http://localhost:8080/api/users
   ```

   **Create a user:**

   ```bash
   curl -X POST http://localhost:8080/api/users \
     -H "Content-Type: application/json" \
     -d '{
       "username": "johndoe",
       "firstname": "John",
       "lastname": "Doe",
       "email": "john@example.com"
     }'
   ```

   **Get user by ID:**

   ```bash
   curl http://localhost:8080/api/users/1
   ```

   **Update user:**

   ```bash
   curl -X PUT http://localhost:8080/api/users/1 \
     -H "Content-Type: application/json" \
     -d '{
       "id": 1,
       "username": "johndoe",
       "firstname": "John",
       "lastname": "Doe Updated",
       "email": "john.updated@example.com"
     }'
   ```

   **Delete user:**

   ```bash
   curl -X DELETE http://localhost:8080/api/users/1
   ```

4. **Use VS Code REST Client (optional):**

   - Install "REST Client" extension
   - Create `test-api.http` file:

   ```http
   ### Get all users
   GET http://localhost:8080/api/users
   
   ### Create user
   POST http://localhost:8080/api/users
   Content-Type: application/json
   
   {
     "username": "testuser",
     "firstname": "Test",
     "lastname": "User",
     "email": "test@example.com"
   }
   ```

   - Click "Send Request" above each request

**✓ Checkpoint:** All REST endpoints respond correctly.

---

### Exercise 8.2: Add API Documentation with Swagger (Optional, 10 minutes)

Spring Boot makes it easy to add interactive API documentation.

1. **Add Swagger dependency:**

   - Ask Copilot:

   ```text
   Add springdoc-openapi dependency to pom.xml for Swagger UI
   ```

2. **Copilot adds to pom.xml:**

   ```xml
   <dependency>
       <groupId>org.springdoc</groupId>
       <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
       <version>2.2.0</version>
   </dependency>
   ```

3. **Add API documentation annotations:**
   - In `UserController.java`, above class:

   ```java
   @RestController
   @RequestMapping("/api/users")
   @Tag(name = "User Management", description = "APIs for managing users")
   public class UserController {
   ```

4. **Document an endpoint:**

   ```java
   @Operation(summary = "Get all users", description = "Retrieves a list of all users")
   @ApiResponse(responseCode = "200", description = "Successfully retrieved users")
   @GetMapping
   public List<User> getAllUsers() {
       return userRepository.findAll();
   }
   ```

5. **Restart app and visit:**
   - **Swagger UI:** [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
   - **OpenAPI spec:** [http://localhost:8080/v3/api-docs](http://localhost:8080/v3/api-docs)

6. **Test APIs directly from Swagger UI!**

**✓ Checkpoint:** Interactive API documentation available.

---

## 9. Testing and Validation

### Exercise 9.1: Generate Unit Tests with Copilot (15 minutes)

Let's use Copilot to generate tests for our modernized code.

1. **Create test for UserController:**
   - New file: `src/test/java/com/example/controller/UserControllerTest.java`

2. **Ask Copilot to generate tests:**

   ```java
   // JUnit 5 test class for UserController
   // Using MockMvc and Mockito
   // Test all CRUD endpoints with success and error cases
   ```

3. **Copilot generates comprehensive tests:**

   ```java
   @WebMvcTest(UserController.class)
   public class UserControllerTest {
       
       @Autowired
       private MockMvc mockMvc;
       
       @MockBean
       private UserRepository userRepository;
       
       @Test
       void testGetAllUsers() throws Exception {
           // Copilot generates test...
       }
       
       @Test
       void testCreateUser() throws Exception {
           // Copilot generates test...
       }
       
       // More tests...
   }
   ```

4. **Ask Copilot for repository tests:**
   - New file: `src/test/java/com/example/repository/UserRepositoryTest.java`
   - Comment: `// Spring Data JPA test for UserRepository using H2 database`

5. **Run tests:**

   ```bash
   mvn test
   ```

6. **Check coverage:**

   ```bash
   mvn clean test jacoco:report
   # Report in target/site/jacoco/index.html
   ```

**✓ Checkpoint:** Tests passing with >70% coverage.

---

### Exercise 9.2: Integration Testing (10 minutes)

Test the full stack together.

1. **Create integration test:**
   - New file: `src/test/java/com/example/UserIntegrationTest.java`

2. **Ask Copilot:**

   ```java
   // Spring Boot integration test using TestRestTemplate
   // Testing full CRUD flow with real database
   // Use @SpringBootTest annotation
   ```

3. **Copilot generates:**

   ```java
   @SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
   public class UserIntegrationTest {
       
       @Autowired
       private TestRestTemplate restTemplate;
       
       @Test
       void testCreateAndRetrieveUser() {
           // Create user
           User newUser = new User();
           newUser.setUsername("testuser");
           newUser.setFirstname("Test");
           newUser.setLastname("User");
           newUser.setEmail("test@example.com");
           
           ResponseEntity<User> response = restTemplate.postForEntity(
               "/api/users", newUser, User.class);
           
           assertEquals(HttpStatus.CREATED, response.getStatusCode());
           assertNotNull(response.getBody().getId());
           
           // Retrieve user
           User retrieved = restTemplate.getForObject(
               "/api/users/" + response.getBody().getId(), User.class);
           
           assertEquals("testuser", retrieved.getUsername());
       }
   }
   ```

4. **Run integration tests:**

   ```bash
   mvn verify
   ```

**✓ Checkpoint:** Integration tests pass, confirming end-to-end functionality.

---

## 10. Preparing for Cloud Deployment

### Exercise 10.1: Create Dockerfile (10 minutes)

Containerize the application for cloud deployment.

1. **Create Dockerfile:**
   - New file: `Dockerfile` (in app-modernized root)

2. **Ask Copilot:**

   ```dockerfile
   # Multi-stage Dockerfile for Spring Boot application
   # Stage 1: Build with Maven
   # Stage 2: Runtime with OpenJDK 17
   # Optimize for Azure Container Apps
   ```

3. **Copilot generates:**

   ```dockerfile
   # Build stage
   FROM maven:3.9-eclipse-temurin-17 AS build
   WORKDIR /app
   COPY pom.xml .
   COPY src ./src
   RUN mvn clean package -DskipTests
   
   # Runtime stage
   FROM eclipse-temurin:17-jre-alpine
   WORKDIR /app
   COPY --from=build /app/target/*.jar app.jar
   EXPOSE 8080
   ENTRYPOINT ["java", "-jar", "app.jar"]
   ```

4. **Build Docker image:**

   ```bash
   docker build -t user-management-api:latest .
   ```

5. **Run locally:**

   ```bash
   docker run -p 8080:8080 \
     -e DATABASE_URL=jdbc:h2:mem:testdb \
     user-management-api:latest
   ```

6. **Test:** [http://localhost:8080/api/users](http://localhost:8080/api/users)

**✓ Checkpoint:** Application runs in Docker container.

---

### Exercise 10.2: Create Azure Deployment Configuration (Optional, 10 minutes)

If time permits and you have Azure access.

1. **Use App Modernization extension:**
   - Open Command Palette: `Ctrl + Shift + P`
   - Run: `App Modernization: Generate Azure Configuration`
   - Select deployment target:
     - Azure App Service (simpler)
     - Azure Container Apps (modern, recommended)
     - Azure Kubernetes Service (advanced)

2. **Extension generates:**
   - `azure.yaml` - Azure Developer CLI config
   - `bicep/` - Infrastructure as Code files
   - GitHub Actions workflow
   - Environment configuration

3. **Deploy to Azure (if configured):**

   ```bash
   # Install Azure Developer CLI (azd)
   winget install Microsoft.AzureDeveloperCLI
   
   # Login
   azd auth login
   
   # Initialize (if not already done)
   azd init
   
   # Deploy
   azd up
   ```

4. **Extension handles:**
   - Creating resource group
   - Provisioning database
   - Deploying application
   - Configuring networking
   - Setting up CI/CD

**✓ Checkpoint:** Application deployed to Azure (optional).

---

## 11. Best Practices and Tips

### Using GitHub Copilot Effectively

#### 1. Write Clear Comments

**Good:**

```java
// REST endpoint to retrieve user by ID with error handling for not found
```

**Bad:**

```java
// get user
```

#### 2. Provide Context

- Keep related files open in tabs
- Use `@workspace` in chat for project-wide context
- Reference existing code patterns

#### 3. Iterate and Refine

- Accept suggestion, then ask for improvements
- Example: "Make this code more efficient" or "Add error handling"

#### 4. Use Chat for Explanations

```text
Explain what @Transactional does in Spring Boot
```

#### 5. Generate Tests Easily

- Select a method
- Right-click > Copilot > Generate Tests

---

### Common Copilot Shortcuts

| Task                  | How to Use Copilot                   |
|-----------------------|--------------------------------------|
| Generate from comment | Write comment, press Enter           |
| Generate entire class | Write class comment at top           |
| Complete method       | Type signature, let Copilot complete |
| Generate tests        | Select method, ask Copilot chat      |
| Refactor code         | Select code, Ctrl+I, ask to refactor |
| Explain code          | Select code, right-click > Explain   |
| Fix errors            | Click error, Copilot suggests fix    |

---

### Troubleshooting Tips

#### Copilot Not Suggesting

1. Check internet connection
2. Verify Copilot icon in status bar is active
3. Try manual trigger: `Alt + \` or `Option + \`
4. Reload VS Code window

#### Build Failures

1. Check Java version: `java -version`
2. Clean Maven cache: `mvn clean`
3. Update dependencies: `mvn dependency:resolve`
4. Check pom.xml for typos

#### Application Won't Start

1. Check port 8080 is not in use
2. Verify database connection in application.properties
3. Check logs in console
4. Use `mvn spring-boot:run -X` for debug logs

---

## Wrap-Up and Next Steps

### What You've Accomplished

Congratulations! In 2 hours, you've:

✅ **Mastered GitHub Copilot** for code generation and assistance  
✅ **Leveraged Copilot Chat** with Claude Sonnet 4.6 for modernization guidance  
✅ **Used App Modernization extension** to assess legacy code  
✅ Assessed a legacy Java application  
✅ Migrated from Java Servlets to Spring Boot  
✅ Replaced 126 lines of JDBC code with 5 lines using Spring Data JPA  
✅ Created modern REST APIs  
✅ Externalized configuration (security best practice)  
✅ Generated comprehensive tests with Copilot  
✅ Containerized the application  
✅ Prepared for cloud deployment  

**Lines of code reduced:** ~50%  
**Development time saved with Copilot:** ~70%  
**Modernization goals achieved:** 8/10  
**AI-assisted code generation:** ~80% of new code  

---

### Continue Learning

1. **GitHub Copilot Mastery:**
   - **Copilot Chat Advanced Features:** Multi-file edits, slash commands, agents
   - **Copilot Enterprise Features:** Knowledge bases, custom instructions
   - **Copilot for CLI:** AI-powered terminal assistance
   - **Copilot Workspace:** Collaborative AI-driven development
   - **Best Practices:** Writing effective prompts and context management

2. **App Modernization Patterns:**
   - **Microservices Architecture:** Breaking monoliths into services
   - **Strangler Fig Pattern:** Incremental modernization strategies
   - **Legacy Migration:** COBOL, .NET Framework, Python 2 to 3
   - **Cross-Platform Migration:** AWS to Azure, GCP to Azure

3. **Spring Boot Advanced (for Java developers):**
   - Spring Security integration
   - Caching with Redis
   - Message queues (RabbitMQ, Kafka)
   - Reactive programming with WebFlux

4. **Azure Cloud Deployment:**
   - Deploy to Azure Container Apps
   - Use Azure SQL Database in production
   - Implement Azure AD authentication
   - Set up Application Insights monitoring

5. **DevOps and CI/CD:**
   - GitHub Actions with Copilot
   - Infrastructure as Code (Bicep/Terraform)
   - Automated testing pipelines
   - Blue-green deployments

---

### Resources

**GitHub Copilot Learning:**

- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [GitHub Copilot Enterprise Guide](https://docs.github.com/enterprise-cloud@latest/copilot/github-copilot-enterprise)
- [Copilot Best Practices](https://docs.github.com/copilot/using-github-copilot/best-practices-for-using-github-copilot)
- [Prompt Engineering for Copilot](https://docs.github.com/copilot/using-github-copilot/prompt-engineering-for-github-copilot)
- [GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/overview)

**App Modernization with Copilot:**

- [GitHub Copilot App Modernization for Java Extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-java-modernization)
- [Azure App Modernization](https://azure.microsoft.com/solutions/application-modernization/)
- **Java Modernization Patterns:** Search in Copilot Chat with `@workspace` for project-specific guidance

**AI-Assisted Development:**

- **Using Copilot for Code Migration:** Ask Copilot "How do I migrate X to Y?" for pattern-specific guidance
- **Testing with Copilot:** Generate tests by asking "Generate unit tests for [class/method]"
- **Documentation with Copilot:** Ask Copilot to explain complex code sections
- **Refactoring with Copilot:** Select code and ask "How can I improve this code?"

**Spring Boot Reference (for self-study):**

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Data JPA](https://spring.io/projects/spring-data-jpa)
- [Spring Boot Guides](https://spring.io/guides)

**Community:**

- [GitHub Copilot Community Discussions](https://github.com/orgs/community/discussions/categories/copilot)
- [VS Code Copilot Chat](https://code.visualstudio.com/docs/copilot/overview) - Use `@github` to ask questions within VS Code
- [Azure Community](https://techcommunity.microsoft.com/azure)

---

### Feedback

Help us improve this hackathon!

**What worked well?**  
**What was confusing?**  
**What would you like to see next?**

---

**Thank you for participating! Keep modernizing! 🚀**
