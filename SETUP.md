# Cline Rules Submodule Setup Instructions

This document provides the steps to incorporate a Cline rule set into your development project using Git submodules. This allows Cline to assist you effectively based on a defined set of rules.

## How to Incorporate Cline Rules into Your Project

Follow these steps to add the `clinerules` repository as a Git submodule:

**0. Cline: Identify Target Branch**

*   **Instruction for Jun-san:** Before proceeding, please tell Cline which specific rule branch from the `clinerules` repository you want to add as a submodule (e.g., `rules/projectA`, `common-rules`, `rules/my-new-project`).
*   **Action for Cline:** (Cline will use `ask_followup_question` to ask Jun-san for the target branch name and store it for use in the next steps.)

**1. Navigate to your project's root directory:**

    ```bash
    cd path/to/your/project
    ```

**2. Add the `clinerules` repository as a Git submodule, tracking the identified target branch:**

    *   **Action for Cline:** (Use the branch name obtained in Step 0 for the `-b` parameter in the command below.)
    ```bash
    # Example: git submodule add -b <target_branch_name_from_step_0> https://github.com/junichi-anada/prompts.git .clinerules
    ```
    *   **Instruction for Jun-san (if executing manually):** Replace `<target_branch_name_from_step_0>` with the branch name you want to track (e.g., `rules/projectA`). Replace `https://github.com/junichi-anada/prompts.git` with the actual HTTPS or SSH URL of the `clinerules` repository.
    *   The `.clinerules` directory is the conventional location for storing Cline rule sets.

**3. Commit the submodule addition:**

    *   **Action for Cline:** (The commit message can be generalized or can include the target branch name.)
    ```bash
    # Example: git add .clinerules .gitmodules && git commit -m "feat: Add .clinerules submodule tracking <target_branch_name_from_step_0>"
    ```
    *   **Instruction for Jun-san (if executing manually):**
    ```bash
    git add .clinerules .gitmodules
    git commit -m "feat: Add .clinerules submodule"
    ```

## Updating the Rules

As the rules in the tracked branch of the `clinerules` repository are updated, you'll need to update the submodule within your project:

```bash
cd path/to/your/project
git submodule update --remote --merge # Or use --rebase
git add .clinerules
git commit -m "chore: Update .clinerules submodule"
```

## Cline is Now Ready to Assist!

With these steps completed, Cline will automatically recognize and apply the rules defined in the `.clinerules` directory when working within your project. You can instruct Cline to read this `SETUP.md` file and execute the commands (using the target branch name you provide) as needed during the initial setup of a new project clone.
