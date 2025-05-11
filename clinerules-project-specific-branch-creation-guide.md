---
description: Guide for creating project-specific rule branches within the .clinerules repository.
author: Cline (with Jun-san's input)
version: 1.0
tags: ["git", "workflow", "clinerules", "branching-strategy", "project-setup"]
globs: ["*"]
---

# Guide: Creating Project-Specific .clinerules Branches

This guide outlines the steps and considerations for creating new project-specific rule branches within the `.clinerules` repository. These branches are intended to store rules and Memory Bank entries tailored to individual development projects (e.g., ProjectA, ProjectB).

## 1. Introduction

This document provides a standardized procedure for creating dedicated branches in the `.clinerules` repository. Each branch will house the specific set of rules and knowledge pertinent to a particular development project, ensuring that Cline can provide contextually accurate and efficient assistance.

## 2. Prerequisites

Before creating a new project-specific rule branch, ensure you have:

*   Basic understanding of Git and its branching model.
*   Access rights to the `.clinerules` repository with permissions to create branches.
*   Familiarity with the purpose and structure of `.clinerules` as defined in `writing-effective-clinerules.md`.

## 3. Branch Creation Strategies

There are two primary strategies for creating a new project-specific rule branch:

### 3.1. Deriving from `common-rules`

This approach is suitable when a new project will largely adhere to the general guidelines and best practices defined in the `common-rules` branch, with some project-specific additions or overrides.

**Considerations:**
*   Provides a solid foundation of established rules.
*   Easier to maintain consistency across projects if `common-rules` are periodically merged.
*   May require careful management of merges if `common-rules` evolves significantly.

### 3.2. Creating an Independent Branch

This approach is suitable when a project has highly unique requirements or will use a completely different set of rules and conventions.

**Considerations:**
*   Offers maximum flexibility for project-specific customization.
*   Requires more effort to establish initial rules and Memory Bank structure.
*   May lead to divergence from common practices if not carefully managed.

## 4. Branch Creation Procedure

### 4.1. Naming Convention

Project-specific rule branches **SHOULD** follow the naming convention:

`rules/<project-name>`

*   Replace `<project-name>` with a short, descriptive, and unique identifier for the project (e.g., `rules/project-alpha`, `rules/webapp-gamma`).
*   Use kebab-case for project names if they consist of multiple words.

### 4.2. Git Commands

**Option A: Deriving from `common-rules` (Recommended for most cases)**

1.  **Ensure your local `common-rules` branch is up-to-date:**
    ```bash
    git checkout common-rules
    git pull origin common-rules
    ```
2.  **Create the new project-specific branch from `common-rules`:**
    ```bash
    git checkout -b rules/<project-name> common-rules
    ```
    *(Replace `<project-name>` with the actual project name)*
3.  **Push the new branch to the remote repository:**
    ```bash
    git push -u origin rules/<project-name>
    ```

**Option B: Creating an Independent Branch (from `main` or another base)**

1.  **Decide on a base branch.** This could be `main` if you want a very minimal starting point, or another branch if appropriate. Ensure it's up-to-date.
    ```bash
    git checkout main # Or your chosen base branch
    git pull origin main # Or your chosen base branch
    ```
2.  **Create the new project-specific branch:**
    ```bash
    git checkout -b rules/<project-name>
    ```
    *(Replace `<project-name>` with the actual project name)*
3.  **Push the new branch to the remote repository:**
    ```bash
    git push -u origin rules/<project-name>
    ```

## 5. Initial Setup After Branch Creation

Once the new project-specific rule branch is created and checked out, perform the following initial setup:

### 5.1. Memory Bank Initialization

1.  **Create the `memory-bank` directory** if it doesn't exist (it should if derived from `common-rules`).
    ```bash
    mkdir -p memory-bank
    ```
2.  **Create/Update Core Memory Bank Files:**
    *   **`memory-bank/projectbrief.md`**: This is the most critical file to start with. Define the project's core purpose, goals, and high-level requirements.
    *   **`memory-bank/productContext.md`**: Detail the "why" behind the project.
    *   **`memory-bank/techContext.md`**: Outline the technology stack.
    *   **`memory-bank/systemPatterns.md`**: Describe architectural patterns.
    *   **`memory-bank/activeContext.md`**: Initialize with current focus (e.g., "Initial project setup").
    *   **`memory-bank/progress.md`**: Initialize with current status (e.g., "Branch created, initial memory bank setup in progress").
    *   Refer to `memory-bank.md` for detailed guidance on the content of these files.
    *   If you derived from `common-rules`, review and customize the template files provided. If independent, create them from scratch or copy templates.

### 5.2. Project-Specific Rules

*   Review any rules inherited from the base branch (if applicable) and adapt or remove them as necessary.
*   Begin creating new `.clinerules` specific to the project's needs (e.g., coding standards, specific tool usage guides).
*   Ensure all rules have appropriate frontmatter (description, author, version, tags, globs).

### 5.3. Commit and Push Initial Setup

```bash
git add memory-bank/
git add .clinerules/ # If you added or modified rules directly in this folder
git commit -m "feat: Initialize memory bank and rules for <project-name>"
git push
```

## 6. Operational Notes

*   **Regular Updates:** Keep the project-specific rules and Memory Bank entries updated as the development project evolves.
*   **Consistency with `common-rules` (if derived):** If your branch was derived from `common-rules`, periodically consider merging updates from `common-rules` to incorporate general improvements. Handle conflicts carefully to preserve project-specific customizations.
    ```bash
    # On your rules/<project-name> branch
    git fetch origin
    git merge origin/common-rules
    ```
*   **Feedback Loop:** Utilize Cline's self-improvement capabilities to refine rules based on interactions and feedback.

This guide provides a starting point. Adapt these procedures as needed to fit the specific workflow and requirements of your team and projects.
