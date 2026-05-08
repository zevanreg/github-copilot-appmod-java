# Hackathon Prerequisites

## App Modernization with GitHub Copilot - Java Edition

### Duration: 2 Hours

This document outlines everything participants need to prepare before the hackathon to ensure a smooth experience.

---

## Table of Contents

1. [System Requirements](#1-system-requirements)
2. [Required Software](#2-required-software)
   - [Java Development Kit (JDK)](#21-java-development-kit-jdk)
   - [Apache Maven](#22-apache-maven)
   - [Visual Studio Code](#23-visual-studio-code)
   - [Git](#24-git)
3. [Required VS Code Extensions](#3-required-vs-code-extensions)
   - [GitHub Copilot](#31-github-copilot-required)
   - [GitHub Copilot App Modernization for Java](#32-github-copilot-app-modernization-for-java-required)
   - [Extension Pack for Java](#33-extension-pack-for-java-highly-recommended)
   - [Additional Recommended Extensions (Optional)](#34-additional-recommended-extensions-optional)
4. [GitHub Account Setup](#4-github-account-setup)
   - [GitHub Account](#41-github-account)
   - [Sign in to VS Code](#42-sign-in-to-vs-code)
   - [Select Claude Sonnet 4.6 as Your Model](#43-select-claude-sonnet-46-as-your-model-recommended)
5. [Azure Subscription Setup](#5-azure-subscription-setup)
   - [Verify Azure Subscription Access](#51-verify-azure-subscription-access)
   - [Install Azure CLI](#52-install-azure-cli)
   - [Sign In to Azure](#53-sign-in-to-azure)
   - [Set the Correct Subscription as Active](#54-set-the-correct-subscription-as-active)
   - [Sign In to Azure in VS Code](#55-sign-in-to-azure-in-vs-code)
6. [Pre-Hackathon Checklist](#6-pre-hackathon-checklist)
7. [Knowledge Prerequisites](#7-knowledge-prerequisites)
8. [Recommended Pre-Reading (Optional)](#8-recommended-pre-reading-optional)
9. [Troubleshooting Common Setup Issues](#9-troubleshooting-common-setup-issues)
10. [Day-of-Hackathon Checklist](#10-day-of-hackathon-checklist)
11. [Support and Help](#11-support-and-help)
12. [What to Expect](#12-what-to-expect)

---

## 1. System Requirements

### Operating System

- **Windows 10/11**, **macOS 10.15+**, or **Linux** (Ubuntu 20.04+ recommended)
- At least **8 GB RAM** (16 GB recommended)
- **20 GB free disk space**

---

## 2. Required Software

### 2.1 Java Development Kit (JDK)

**Minimum Required:** JDK 11  
**Recommended:** JDK 17 or JDK 21 (latest LTS versions)

**Installation:**

**Windows:**

```powershell
# Using winget
winget install Microsoft.OpenJDK.17

# Or download from:
# https://adoptium.net/
```

**macOS:**

```bash
# Using Homebrew
brew install openjdk@17

# Add to PATH in ~/.zshrc or ~/.bash_profile
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
```

**Linux:**

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-17-jdk

# Verify installation
java -version
```

**Verification:**

```bash
java -version
# Should output: openjdk version "17.x.x" or higher
```

---

### 2.2 Apache Maven

**Required Version:** 3.9.0 or higher (recommended: 3.9.x)

**Installation:**

**Windows (Manual Installation - Recommended):**

**Note:** Maven is not available on winget. Follow these steps for manual installation:

1. **Download Maven:**
   - Go to https://maven.apache.org/download.cgi
   - Download the "Binary zip archive" (e.g., `apache-maven-3.9.9-bin.zip`)

2. **Extract to a permanent location:**
   ```powershell
   # Create tools directory if it doesn't exist
   New-Item -ItemType Directory -Path "$env:USERPROFILE\tools" -Force
   
   # Extract the downloaded zip to %USERPROFILE%\tools
   # Example: Extract to C:\Users\YourName\tools\apache-maven-3.9.9
   ```

3. **Add Maven to PATH:**
   ```powershell
   # Add Maven bin directory to PATH (replace with your actual path)
   $mavenPath = "$env:USERPROFILE\tools\apache-maven-3.9.9\bin"
   [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$mavenPath", "User")
   
   # Restart your terminal or VS Code for changes to take effect
   ```

4. **Verify installation:**
   ```powershell
   # Open a NEW terminal window
   mvn -version
   # Should output: Apache Maven 3.9.x
   ```

**Windows (Alternative - Chocolatey):**

```powershell
choco install maven
```

**macOS:**

```bash
brew install maven
```

**Linux:**

```bash
sudo apt update
sudo apt install maven
```

**Verification:**

```bash
mvn -version
# Should output: Apache Maven 3.9.x or higher
```

---

### 2.3 Visual Studio Code

**Required Version:** Latest stable release

**Download:** [Visual Studio Code](https://code.visualstudio.com/)

**Installation:**

- Download the installer for your platform
- Run the installer and follow the prompts
- Launch VS Code after installation

---

### 2.4 Git

**Required Version:** 2.30 or higher

**Installation:**

**Windows:**

```powershell
winget install Git.Git
```

**macOS:**

```bash
# Usually pre-installed, or use Homebrew
brew install git
```

**Linux:**

```bash
sudo apt install git
```

**Verification:**

```bash
git --version
```

---

## 3. Required VS Code Extensions

Install these extensions in VS Code **before the hackathon**:

### Quick Installation (Recommended)

Install all required extensions at once using their extension IDs:

1. **Open VS Code terminal** (`` Ctrl+` ``)
2. **Run these commands** one by one:

```powershell
# Install GitHub Copilot Chat
code --install-extension GitHub.copilot-chat

# Install App Modernization for Java
code --install-extension vscjava.migrate-java-to-azure

# Install Extension Pack for Java
code --install-extension vscjava.vscode-java-pack
```

3. **Restart VS Code** after installation

---

### Manual Installation (Alternative)

If you prefer to install manually:

### 3.1 GitHub Copilot Chat (Required)

**Extension ID:** `GitHub.copilot-chat`

**Installation:**

1. Open VS Code Extensions view (`Ctrl+Shift+X` / `Cmd+Shift+X`)
2. Search for "GitHub Copilot Chat"
3. Click **Install**

**Note:** This enables the chat panel and inline chat features for Copilot

**Requirements:**

- Active GitHub Copilot subscription (Individual, Business, or Enterprise)
- GitHub account signed in to VS Code

---

### 3.2 GitHub Copilot App Modernization for Java (Required)

**Extension ID:** `vscjava.migrate-java-to-azure`

**Installation:**

1. Open VS Code Extensions view (`Ctrl+Shift+X` / `Cmd+Shift+X`)
2. Search for "GitHub Copilot App Modernization for Java"
3. Click **Install**

**Note:** This extension may also be called "Migrate Java to Azure" or "App Modernization"

---

### 3.3 Extension Pack for Java (Highly Recommended)

**Extension ID:** `vscjava.vscode-java-pack`

This pack includes:

- Language Support for Java (Red Hat)
- Debugger for Java
- Test Runner for Java
- Maven for Java
- Project Manager for Java
- Visual Studio IntelliCode

**Installation:**

1. Search for "Extension Pack for Java" in Extensions view
2. Click **Install** (this will install all included extensions)

---

### 3.4 Additional Recommended Extensions (Optional)

- **Spring Boot Extension Pack** (`vmware.vscode-boot-dev-pack`) - For Spring Boot modernization
- **Database Client** (`cweijan.vscode-database-client2`) - For database inspection
- **YAML** (`redhat.vscode-yaml`) - For configuration files

---

## 4. GitHub Account Setup

### 4.1 GitHub Account

- You should already have a **GitHub account** provided by your organization
- Ensure your email address is verified
- You have been provisioned with **GitHub Copilot Enterprise** license

### 4.2 Sign in to VS Code

1. Open VS Code
2. Click the **Accounts** icon in the bottom-left corner
3. Select **Sign in with GitHub**
4. Complete the authentication flow in your browser
5. Return to VS Code - you should see your GitHub username

**Verification:**

- Look for the Copilot icon in the VS Code status bar (bottom-right)
- The icon should not have a warning symbol
- Click the icon to verify "GitHub Copilot is active"
- Verify you see "GitHub Copilot Enterprise" in the status

### 4.3 Select Claude Sonnet 4.6 as Your Model (Recommended)

For the best experience during this hackathon, we recommend using **Claude Sonnet 4.6** as your Copilot model.

**Why Claude Sonnet 4.6?**

- Superior code generation quality for Java modernization
- Better understanding of Spring Boot patterns
- More accurate assessment and migration suggestions
- Excellent at explaining complex modernization concepts

**Steps to Select Claude Sonnet 4.6:**

1. **Open Copilot Chat:**
   - Click the chat icon in the Activity Bar (left side)
   - OR press `Ctrl + Alt + I` (Windows/Linux) or `Cmd + Alt + I` (macOS)

2. **Access Model Selector:**
   - Look for the model dropdown at the top of the chat panel
   - It may show "Default" or another model name
   - Click on the model name/dropdown

3. **Select Claude Sonnet 4.6:**
   - In the model list, find and select **"Claude Sonnet 4.6 (Copilot)"**
   - Alternative names might be: "Claude 3.7 Sonnet" or "Sonnet 4.6"
   - The selection will be saved for your session

4. **Verify Selection:**
   - The model dropdown should now display "Claude Sonnet 4.6"
   - Ask a test question: "What model are you using?"
   - Copilot should confirm it's using Claude Sonnet 4.6

**Alternative Method via Settings:**

1. Open VS Code Settings (`Ctrl + ,` or `Cmd + ,`)
2. Search for "copilot model"
3. Find "GitHub > Copilot > Advanced: Model"
4. Select "claude-sonnet-4.6" from the dropdown

**Note:** If you don't see Claude Sonnet 4.6 in the list, ensure:

- Your Copilot Enterprise license is active
- VS Code and Copilot extension are up to date
- You're signed in with your enterprise GitHub account

---

## 5. Azure Subscription Setup

### 5.1 Verify Azure Subscription Access

You have been provided with an Azure subscription for this hackathon. Let's verify it's configured correctly.

**Prerequisites:**

- Azure subscription assigned to you
- Subscription ID or name provided by organizers
- Contributor or Owner role on the subscription

### 5.2 Install Azure CLI

The Azure CLI is required for deploying applications to Azure.

**Windows:**

```powershell
# Using winget (recommended)
winget install Microsoft.AzureCLI

# Or download MSI installer from:
# [Install Azure CLI on Windows](https://aka.ms/installazurecliwindows)
```

**macOS:**

```bash
brew install azure-cli
```

**Linux:**

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Verification:**

```bash
az --version
# Should show: azure-cli 2.50.0 or higher
```

### 5.3 Sign In to Azure

1. **Login to Azure:**

   ```bash
   az login
   ```

   This will open a browser window for authentication.

2. **Authenticate:**
   - Sign in with your organization credentials
   - Close the browser when you see "You have signed in"

3. **Verify Login:**

   ```bash
   az account show
   ```

   You should see your account details including subscription information.

### 5.4 Set the Correct Subscription as Active

If you have access to multiple subscriptions, ensure the hackathon subscription is set as active.

1. **List all subscriptions:**

   ```bash
   az account list --output table
   ```

   **Example output:**

   ```bash
   Name                      SubscriptionId                        State    IsDefault
   ------------------------  ------------------------------------  -------  -----------
   Hackathon-Subscription    12345678-1234-1234-1234-123456789012  Enabled  True
   Production-Subscription   87654321-4321-4321-4321-210987654321  Enabled  False
   ```

2. **Identify your hackathon subscription:**
   - Look for the subscription name you'd like to use (e.g., "Hackathon-Subscription")
   - Note the SubscriptionId

3. **Set as active subscription:**

   ```bash
   az account set --subscription "<subscription-name-or-id>"
   ```

   **Example:**

   ```bash
   az account set --subscription "Hackathon-Subscription"
   # OR
   az account set --subscription "12345678-1234-1234-1234-123456789012"
   ```

4. **Verify the correct subscription is active:**

    ```bash
    az account show --output table
    ```

   Confirm the "Name" matches your hackathon subscription.

**Note:** You do NOT need to install the Azure Account extension in VS Code. The Azure CLI (`az login`) is sufficient for this hackathon. Azure deployment tasks will use the CLI credentials.

---

## 6. Pre-Hackathon Checklist

Complete this checklist **at least 1 day before** the hackathon:

### Software Installation

- [ ] JDK 11+ installed and verified (`java -version`)
- [ ] Maven 3.9+ installed and verified (`mvn -version`)
- [ ] VS Code installed and launched successfully
- [ ] Git installed and verified (`git --version`)

### VS Code Extensions

- [ ] GitHub Copilot Chat extension installed (`GitHub.copilot-chat`)
- [ ] GitHub Copilot App Modernization for Java extension installed (`vscjava.migrate-java-to-azure`)
- [ ] Extension Pack for Java installed (`vscjava.vscode-java-pack`)
- [ ] All extensions show as "Enabled" (not disabled or errored)

### GitHub Account & Copilot

- [ ] GitHub account created and email verified
- [ ] Signed in to GitHub in VS Code (account icon bottom-left)
- [ ] GitHub Copilot Enterprise license active
- [ ] Copilot status bar icon shows "active" (no warning symbol)
- [ ] Claude Sonnet 4.6 model selected in Copilot chat
- [ ] Model selection verified (ask "What model are you using?")

### Azure Account

- [ ] Azure CLI installed and verified (`az --version`)
- [ ] Signed in to Azure (`az login` completed)
- [ ] Correct hackathon subscription set as active (`az account show`)

### Test GitHub Copilot

- [ ] Create a new `.java` file in VS Code
- [ ] Type `// Function to calculate factorial` and press Enter
- [ ] Verify Copilot suggests code (gray text appears)
- [ ] Accept a suggestion with Tab key
- [ ] Test Copilot Chat with Claude Sonnet 4.6

### Fork and Clone Hackathon Repository

**Important:** You will work on your own fork of the repository to avoid conflicts and enable you to track your changes.

#### Step 1: Fork the Repository

1. Navigate to the hackathon repository (URL provided by organizer):
   ```
   https://github.com/iamvighnesh/github-copilot-appmod-java
   ```

2. Click the **"Fork"** button in the top-right corner of the page

3. Select your GitHub account as the destination

4. Wait for GitHub to create your fork (should take a few seconds)

5. You now have your own copy at:
   ```
   https://github.com/YOUR-USERNAME/github-copilot-appmod-java
   ```

#### Step 2: Clone Your Fork Locally

```bash
# Replace YOUR-USERNAME with your actual GitHub username
git clone https://github.com/YOUR-USERNAME/github-copilot-appmod-java.git
cd github-copilot-appmod-java
```

#### Step 3: (Optional) Add Upstream Remote

This allows you to pull updates from the original repository if needed:

```bash
# Add the original repository as "upstream"
git remote add upstream https://github.com/iamvighnesh/github-copilot-appmod-java.git

# Verify your remotes
git remote -v
# Should show:
# origin    https://github.com/YOUR-USERNAME/github-copilot-appmod-java.git (fetch)
# origin    https://github.com/YOUR-USERNAME/github-copilot-appmod-java.git (push)
# upstream  https://github.com/iamvighnesh/github-copilot-appmod-java.git (fetch)
# upstream  https://github.com/iamvighnesh/github-copilot-appmod-java.git (push)
```

### Verify Maven Build

```bash
cd app
mvn clean compile

# Expected output: BUILD SUCCESS
```

### Workspace Setup

- [ ] Repository forked to your GitHub account
- [ ] Fork cloned to local machine
- [ ] Open the folder in VS Code: `File > Open Folder > Select 'github-copilot-appmod-java'`
- [ ] Maven dependencies downloaded successfully
- [ ] No red errors in Java files (yellow warnings are OK)

---

## 7. Knowledge Prerequisites

### Required Knowledge

- **Basic Java understanding** (classes, methods, variables)
- **Basic command line usage** (running commands in terminal)
- **Basic VS Code familiarity** (opening files, using the editor)

### Helpful But Not Required

- Familiarity with Spring Boot
- Experience with Maven or Gradle
- Understanding of REST APIs
- Database/SQL knowledge (basic understanding of Sybase vs Azure SQL)
- Cloud concepts (especially Azure)

### No Experience Required With

- GitHub Copilot (we'll teach you!)
- App modernization patterns
- Legacy-to-modern migrations
- Azure SQL Database
- Azure deployment

---

## 8. Recommended Pre-Reading (Optional)

To get the most out of the hackathon, consider reviewing:

### GitHub Copilot Learning

**Essential:**
- **[GitHub Copilot Documentation](https://docs.github.com/en/copilot)** - Overview and features
- **[Getting Started with GitHub Copilot](https://docs.github.com/en/copilot/getting-started-with-github-copilot)** - Setup and basics
- **[Using GitHub Copilot Chat](https://docs.github.com/en/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide)** - Interactive AI assistance
- **[Best Practices for GitHub Copilot](https://docs.github.com/copilot/using-github-copilot/best-practices-for-using-github-copilot)** - Tips for effective prompts

**App Modernization:**
- **[GitHub Copilot App Modernization for Java](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-java-modernization)** - Extension overview
- **[Prompt Engineering Tips](https://docs.github.com/copilot/using-github-copilot/prompt-engineering-for-github-copilot)** - Writing effective prompts

### Java Modernization Concepts

- **Legacy Servlet vs. Spring Boot:** Understanding the differences
- **JDBC vs. JPA/Hibernate:** Modern data access patterns
- **REST API basics:** Moving from server-side rendering to APIs

### Quick References

- **Maven Basics:** Understanding `pom.xml` structure
- **Azure SQL Database:** Understanding cloud databases vs on-premises
- **Using `#codebase` in Copilot Chat:** How to give Copilot full project context

---

## 9. Troubleshooting Common Setup Issues

### Issue: "Java not found" or wrong version

**Solution:**

```bash
# Check all Java installations
# Windows
where java

# macOS/Linux
which java

# Set JAVA_HOME environment variable to correct JDK
# Windows (PowerShell)
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"

# macOS/Linux
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

### Issue: GitHub Copilot not activating

**Solution:**

1. Verify you're signed in with your organization GitHub account (not personal)
2. Check Enterprise license status with your GitHub admin
3. Sign out and sign back in to VS Code
4. Reload VS Code window (`Ctrl+Shift+P` → "Reload Window")
5. Check VS Code Output panel: `View > Output > GitHub Copilot`

### Issue: Claude Sonnet 4.6 not available in model list

**Solution:**

1. Ensure you have GitHub Copilot Enterprise (not Individual/Business)
2. Update VS Code to the latest version
3. Update GitHub Copilot Chat extension to the latest version
4. Reload VS Code and check the model list again
5. Contact your GitHub admin if still unavailable

### Issue: Cannot set Azure subscription

**Solution:**

```bash
# Clear Azure CLI cache
az account clear

# Login again
az login

# List and set subscription
az account list --output table
az account set --subscription "<subscription-id>"
```

### Issue: Maven command not found or "mvn is not recognized"

**Solution (Windows):**

```powershell
# Verify Maven was extracted correctly
Test-Path "$env:USERPROFILE\\tools\\apache-maven-3.9.9\\bin\\mvn.cmd"

# Add to PATH for current session
$env:Path += ";$env:USERPROFILE\\tools\\apache-maven-3.9.9\\bin"

# Add permanently (restart terminal after)
$mavenPath = "$env:USERPROFILE\\tools\\apache-maven-3.9.9\\bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$mavenPath", "User")

# Verify
mvn -version
```

**Solution (macOS/Linux):**

```bash
# Add to your shell profile (~/.bashrc, ~/.zshrc, or ~/.bash_profile)
export PATH="/usr/local/maven/bin:$PATH"

# Reload profile
source ~/.bashrc  # or ~/.zshrc
```

### Issue: Maven build fails with "dependencies not found"

**Solution:**

```bash
# Clear Maven cache
rm -rf ~/.m2/repository

# Rebuild with force update
mvn clean install -U
```

### Issue: VS Code extensions not installing

**Solution:**

1. Check internet connection
2. Check corporate proxy settings
3. Try installing manually from VSIX file
4. Check VS Code Output: `View > Output > Extensions`

### Issue: Git clone fails

**Solution:**

```bash
# If HTTPS fails, ensure Git is configured
git config --global http.sslVerify true

# Or use SSH if you have SSH keys set up (replace YOUR-USERNAME)
git clone git@github.com:YOUR-USERNAME/github-copilot-appmod-java.git
```

### Issue: Cannot fork repository

**Common causes:**

- Not signed in to GitHub - ensure you're logged in
- Already have a fork - check your GitHub repositories
- Organization restrictions - contact your GitHub admin

**Solution:**

```
1. Go to https://github.com/YOUR-USERNAME
2. Check if "github-copilot-appmod-java" already exists in your repositories
3. If it exists, delete the old fork and create a new one, or clone the existing fork
4. If you cannot fork, contact the hackathon organizer for assistance
```

---

## 10. Day-of-Hackathon Checklist

On hackathon day, ensure:

- [ ] Laptop fully charged (bring charger!)
- [ ] All software installed and verified
- [ ] GitHub Copilot Enterprise active in VS Code
- [ ] Claude Sonnet 4.6 model selected and verified
- [ ] Azure subscription active and set correctly
- [ ] Repository forked and cloned to local machine
- [ ] VS Code opened with your forked repository
- [ ] Stable internet connection
- [ ] Notebook/notepad for taking notes
- [ ] Questions prepared for facilitators

---

## 11. Support and Help

### During Setup

If you encounter issues during setup:

1. Check the Troubleshooting section above
2. Search VS Code Output logs: `View > Output`
3. Contact hackathon organizers with:
   - Your operating system and version
   - Error messages (screenshots helpful)
   - Steps you've already tried

### During Hackathon

Facilitators will be available to help with:

- Technical issues
- GitHub Copilot usage questions
- Modernization strategy questions
- Azure SQL migration questions
- Azure deployment questions

---

## 12. What to Expect

### Hackathon Format

- **Duration:** 2 hours

- **Format:** Hands-on coding with guidance
- **Structure:**
  - 15 min: Introduction and overview
  - 15 min: GitHub Copilot basics
  - 75 min: Guided modernization exercises
  - 15 min: Wrap-up and Q&A

### You Will Learn

- How to use GitHub Copilot for app modernization
- Identifying modernization opportunities
- Migrating from legacy patterns to modern frameworks
- Database migration strategies from Sybase to Azure SQL
- Best practices for cloud-ready applications

### You Will Build

By the end of the hackathon, you will have:

- Modernized the legacy Java servlet application
- Migrated to Spring Boot framework
- Updated to modern Java versions
- Refactored database access patterns from Sybase to Azure SQL
- Added REST API endpoints
- Prepared the app for Azure cloud deployment

---

## Ready to Begin?

Once you've completed all prerequisites and verified your setup, you're ready for the hackathon!

See you there! 🚀
