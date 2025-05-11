# General Workflow Guidelines

This document outlines the general workflow guidelines to be followed by both Jun-san (the developer) and Cline (the AI assistant) for projects managed within this `clinerules` repository structure.

## 1. Branching Strategy

This `clinerules` repository itself has a specific branching model:

*   **`main` branch:**
    *   Reserved strictly for synchronizing with the upstream repository.
    *   No direct commits or local development should occur on this branch.
*   **`common-rules` branch:**
    *   Contains general, project-agnostic rules, workflows, and principles that apply across multiple development projects.
    *   This branch serves as a base or reference for project-specific rule branches.
*   **Project-specific rule branches (e.g., `rules/projectA`, `rules/projectB`):**
    *   Created for each individual development project (e.g., ProjectA, ProjectB).
    *   These branches store rules and Memory Bank entries specific to that particular project.
    *   They may be derived from `common-rules` or created independently while referencing `common-rules`.

For individual development projects, a standard Gitflow-like or feature branch workflow is generally recommended. Specific guidelines and templates for project-level branching strategies can be found in `.clinerules/project-branching-strategy.md`. It is advised to copy this template into the respective project's `.clinerules` directory (e.g., `rules/YourProjectName/project-branching-strategy.md`) and customize it as needed.

The `.clinerules` for a specific project will typically be included as a Git submodule, tracking the corresponding project-specific rule branch from this `clinerules` repository (e.g., `ProjectA`'s submodule tracks `clinerules/rules/projectA`).

## 2. Commit Message Conventions

To maintain a clear and understandable commit history, we will adhere to the [Conventional Commits](https://www.conventionalcommits.org/) specification.

**Format:**

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Common Types:**

*   `feat`: A new feature.
*   `fix`: A bug fix.
*   `docs`: Documentation only changes.
*   `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
*   `refactor`: A code change that neither fixes a bug nor adds a feature.
*   `perf`: A code change that improves performance.
*   `test`: Adding missing tests or correcting existing tests.
*   `build`: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm).
*   `ci`: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs).
*   `chore`: Other changes that don't modify `src` or `test` files.
*   `revert`: Reverts a previous commit.

**Example:**

```
feat(auth): implement user login endpoint

Adds the /api/login endpoint with email and password authentication.
Returns a JWT token upon successful login.

Fixes #123
```

## 3. Cline Interaction Principles

*   Cline will primarily operate based on the rules and Memory Bank found within the `.clinerules` submodule of the active development project.
*   Updates to rules or Memory Bank entries will be made within the submodule, committed, and pushed to the corresponding branch in the `clinerules` origin repository. The parent project will then update its submodule reference.
*   Cline will strive to follow the "Continuous Improvement Protocol" and "Memory Bank" guidelines defined in the `common-rules` branch (or the project-specific override if one exists).

## 4. ClineRule Management and Refactoring

`.clinerules` evolve with project growth and changes. If existing rules become large or encompass multiple concerns, consider refactoring them by splitting them into smaller, more specific files, each with a single responsibility.

When rules are split, ensure that references between related rules are updated accordingly. Obsolete files or directories should be removed to maintain a clean and understandable ruleset.
