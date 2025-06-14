# My Prompts Rule Source (Fork of cline/prompts)

This repository is a fork of the original [cline/prompts](https://github.com/cline/prompts.git).

## Purpose

The primary purpose of this fork is to serve as a source for my custom `.clinerules` that can be selectively copied into my other projects. It also allows syncing with the upstream `cline/prompts` repository to get the latest rules without directly modifying this fork's main branches.

## Workflow

### 1. Syncing with Upstream

To get the latest rules from the original `cline/prompts` repository:

1.  Ensure the `upstream` remote is configured:
    ```bash
    git remote add upstream https://github.com/cline/prompts.git
    # (If it already exists, this command will notify you)
    ```
2.  Checkout the `main` branch:
    ```bash
    git checkout main
    ```
3.  Fetch and merge the latest changes from the upstream repository:
    ```bash
    git fetch upstream
    git merge upstream/main # Or the relevant branch from upstream
    # Resolve any conflicts if necessary
    ```
    The `main` branch now contains the latest rules from `cline/prompts`.

### 2. Utilizing Rules in Other Projects

To use rules from this repository in another project (e.g., `/path/to/your/project`):

1.  Navigate to your target project's directory:
    ```bash
    cd /path/to/your/project
    ```
2.  Ensure the `.clinerules` directory exists:
    ```bash
    mkdir -p .clinerules
    ```
3.  Copy the required rule files from the `my-rules` branch of *this* repository (e.g., `/path/to/this/fork`) to your target project's `.clinerules` directory:
    ```bash
# Example: Copying a specific rule file
cp /home/rbsdev/Project/prompts/.clinerules/some-rule.md ./clinerules/

# Example: Copying a rule directory
cp -r /home/rbsdev/Project/prompts/.clinerules/some-rule-directory ./clinerules/
```
    *(このリポジトリの実際のパス: `/home/rbsdev/Project/prompts`)*
