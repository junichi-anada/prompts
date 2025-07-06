---
title: "GitHub Workflow and Branch Management"
description: "Rules for GitHub workflow and branch management, specifying tool execution paths in GitHub Actions workflows and ensuring consistent execution in CI/CD environments!"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["GitHub", "CI/CD", "best-practices", "ベストプラクティス", "workflow", "ワークフロー", "branch-management", "ブランチ管理"]
globs: ["*"]
---

# GitHub Workflow and Branch Management

**For Cline:** This document outlines the standard Git workflows and branch management practices for this project. Refer to this guide when performing version control tasks, especially feature development, bug fixing, and merging pull requests.

## GitHub Branching Strategy (GitHub Flow)

**For Cline:** This section explains the primary branching model used. Understand this flow to correctly create and manage branches for new work.

```mermaid
graph TD
    A[main (Always Deployable)] --> B(Create feature/new-feature or fix/bug-fix branch);
    B --> C{Work Complete};
    C --> D[Create Pull Request];
    D --> E{Code Review};
    E --> F[Merge to main];
    F --> G(Deploy);
    F --> A;
```

**Branching Strategy Explanation:**

*   **`main` Branch**:
    *   **Purpose**: Represents the production-ready code.
    *   **Rule**: Must always be stable and deployable.
    *   **Restriction**: **Direct commits to `main` are prohibited.**
*   **`feature/*` or `fix/*` Branches**:
    *   **Purpose**: Isolate work for new features (e.g., `feature/add-user-authentication`) or bug fixes (e.g., `fix/resolve-login-issue`).
    *   **Creation**: Branched from the `main` branch.
    *   **Workflow**:
        1.  Complete development or fix on this branch.
        2.  Create a Pull Request to merge changes into `main`.
*   **Pull Request (PR)**:
    *   **Purpose**: Facilitate code review and discussion before merging changes into `main`.
    *   **Process**:
        1.  Team members review the changes.
        2.  Address any feedback or make necessary corrections.
        3.  Once approved, merge the PR into the `main` branch.
*   **Deployment**:
    *   **Trigger**: Occurs after changes are merged into the `main` branch.
    *   **Method**: Can be automatic (CI/CD) or manual.

## Git Branch Management

**For Cline:** This section provides guidelines for managing local and remote branches, focusing on deletion and synchronization. Adhere to these procedures to maintain a clean and consistent repository state.

### Local Branch Deletion

**Objective**: Safely and effectively remove local branches that are no longer needed.

**Procedures and Precautions:**

*   **Prerequisite: Checkout to a different branch**:
    *   **Rule**: You cannot delete the branch you are currently on.
    *   **Action**: Switch to another branch (e.g., `main` or `develop`) first.
    *   **Example**: `git checkout main`
*   **Standard Deletion (Merged Branches)**:
    *   **Command**: `git branch -d <branch-name>`
    *   **Behavior**: Safely deletes the branch **only if it has been merged** into your current `HEAD` or another branch specified.
    *   **Example**: `git branch -d feature/old-feature`
*   **Force Deletion (Unmerged Branches - Use with Extreme Caution)**:
    *   **Command**: `git branch -D <branch-name>`
    *   **Behavior**: Forcibly deletes the branch, even if it has unmerged changes.
    *   **Warning**: **Potential for data loss. Ensure unmerged commits are intentionally discarded or merged elsewhere.**
    *   **Example**: `git branch -D feature/experimental-feature`
*   **Understanding Warning Messages**:
    *   **Action**: Pay close attention to any warnings displayed during branch deletion.
    *   **Example Scenario**: A message like "warning: deleting branch 'branch-name' that has been merged to 'refs/remotes/origin/branch-name', but not yet merged to HEAD." indicates the local `HEAD` (e.g., `main`) might be behind the remote. Consider updating your `main` branch.

### Branch Synchronization

**Objective**: Maintain consistency between your local and remote repositories.

**Guidelines:**

*   **Keep `main` Branch Updated**:
    *   **Recommendation**: Regularly update your local `main` branch with the latest changes from the remote.
    *   **Benefit**: Reduces merge conflicts and warnings during branch operations.
    *   **Example**: `git checkout main && git pull origin main`
*   **Remote Branch Deletion (After Local Deletion)**:
    *   **Consideration**: If a local branch is deleted and its remote counterpart is no longer needed, delete the remote branch as well.
    *   **Example**: `git push origin --delete <branch-name>`

## Pull Request Merging with MCP

**For Cline:** This section details the process for merging Pull Requests using the GitHub MCP server. Follow these steps when you are tasked with merging a PR. **All MCP operations are performed in Act Mode.**

### Merging Pull Requests

**Process:**

1.  **Information Gathering (Crucial Pre-step)**:
    *   **Action**: Before attempting a merge, confirm the following details with the user:
        *   Repository owner name (e.g., `username` or `organization-name`)
        *   Repository name (e.g., `my-project`)
        *   Pull Request number (e.g., `123`)
        *   Merge method (e.g., `"merge"`, `"squash"`, `"rebase"`).
            *   **Default**: If not specified by the user, assume `"merge"`.
2.  **Using MCP Tools (Execution Step)**:
    *   **Tool**: `merge_pull_request`
    *   **Server**: `github.com/modelcontextprotocol/servers/tree/main/src/github`
    *   **Arguments**:
        *   `owner`: (string) Repository owner name
        *   `repo`: (string) Repository name
        *   `pull_number`: (integer) Pull request number
        *   `merge_method`: (string, optional) Merge method
3.  **Execution Confirmation (Reporting Step)**:
    *   **Action**: After the MCP tool attempts the merge, report the outcome (success or failure, along with any messages) to the user.

### General Considerations for Cline

*   **Mode Confirmation (Critical for MCP Usage)**:
    *   **Rule**: **Ensure you are in Act Mode before using MCP tools for merging.**
    *   **Clarification**: Planning, discussion, and obtaining user approval for the merge (including gathering necessary information) should occur in Plan Mode. Only switch to Act Mode for the actual execution of the `merge_pull_request` tool.
*   **Clear Communication**:
    *   **Rule**: Always communicate clearly and concisely with the user.
    *   **Objective**: Ensure all necessary information is accurately conveyed and understood before and after operations.
