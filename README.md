# Cline Rules Repository

This repository manages the rule sets and associated Memory Bank entries that govern the behavior of Cline, your AI software engineering assistant. The rules defined here are intended to be used as a Git submodule within individual development projects.

## Repository Purpose

The primary goal of this repository is to:

1.  Provide a centralized location for managing all `.clinerules` that Cline uses.
2.  Enable consistent Cline behavior across multiple development projects.
3.  Allow for project-specific customization of rules while maintaining a common base.
4.  Facilitate version control and evolution of Cline's operational guidelines.

## Branching Strategy

This repository employs a specific branching model to manage common and project-specific rules:

*   **`main` branch:**
    *   **Purpose:** Strictly for synchronizing with the upstream repository (if this is a fork).
    *   **Usage:** No direct commits or local development should occur on this branch. It serves as a clean reference to the original source.

*   **`common-rules` branch:**
    *   **Purpose:** Contains general, project-agnostic rules, workflows, and principles applicable across multiple development projects. This includes Cline's core interaction principles and general workflow guidelines.
    *   **Usage:** This branch acts as a foundational layer or template for project-specific rule sets. Updates to common rules are made here.
    *   **Key Files:**
        *   `general-workflow-guidelines.md`: Outlines repository-level branching, commit conventions, and general development workflows.
        *   `cline-interaction-principles.md`: Defines Cline's core operational behaviors, Memory Bank management, and rule interpretation logic.
        *   `memory-bank/`: Contains Memory Bank entries related to the management and purpose of these common rules themselves.

*   **Project-Specific Rule Branches (e.g., `rules/projectA`, `rules/projectB`):**
    *   **Purpose:** To store rule sets and Memory Bank entries tailored to a specific development project (e.g., ProjectA, ProjectB).
    *   **Usage:**
        *   Typically created by branching from `common-rules` (to inherit common guidelines) or by starting fresh and selectively incorporating common rules.
        *   These branches are intended to be checked out as submodules by the respective development projects.
    *   **Structure within a project-specific branch (e.g., `rules/projectA`):**
        *   It will contain copies or versions of common rules (like `general-workflow-guidelines.md`, `cline-interaction-principles.md`).
        *   It will also contain project-specific rule files (e.g., `projecta-laravel-best-practices.md`).
        *   A `memory-bank/` directory will store Memory Bank entries pertinent to the *ruleset* for that specific project (e.g., why a particular Laravel rule was chosen for ProjectA).

## How to Use with Development Projects

1.  **For a New Development Project (e.g., "ProjectX"):**
    1.  In this `clinerules` repository, create a new branch, for example, `rules/projectX`. It's recommended to base this off the `common-rules` branch.
        ```bash
        git checkout common-rules
        git checkout -b rules/projectX
        ```
    2.  Customize/add rules specific to ProjectX within the `rules/projectX` branch (e.g., `projectx-specific-tech-guide.md`).
    3.  Commit and push the `rules/projectX` branch.
        ```bash
        git add .
        git commit -m "feat(rules): setup initial rules for ProjectX"
        git push origin rules/projectX
        ```
    4.  In your actual "ProjectX" application repository, add this `clinerules` repository as a Git submodule, tracking the `rules/projectX` branch. It's conventional to place it in a directory named `.clinerules`.
        ```bash
        # Navigate to your ProjectX application's root directory
        git submodule add -b rules/projectX <URL_of_this_clinerules_repo> .clinerules
        git commit -m "feat: add .clinerules submodule for ProjectX"
        ```

2.  **Cline's Interaction:**
    *   When Cline is activated within a development project (e.g., ProjectX), it will look for a `.clinerules` directory in the project root.
    *   It will then read and apply the rules and Memory Bank entries found within that `.clinerules` directory.

## Updating Rules

*   **Common Rules:** Modify files in the `common-rules` branch, commit, and push. These changes can then be propagated to project-specific branches via merging or rebasing as needed.
*   **Project-Specific Rules:** Modify files within the relevant project-specific rule branch (e.g., `rules/projectA`), commit, and push.
*   **In Development Projects:** After rules are updated in this `clinerules` repository, navigate to the development project's directory and update the submodule:
    ```bash
    cd path/to/your/ProjectX
    git submodule update --remote --merge # Or --rebase
    git add .clinerules
    git commit -m "chore: update .clinerules to latest"
    ```

This structured approach ensures that Cline operates consistently and effectively, tailored to the specific needs of each project while benefiting from a shared set of common principles.
