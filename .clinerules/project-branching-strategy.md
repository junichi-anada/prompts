---
description: A general template for defining a project's branching strategy, typically based on Gitflow or feature branches. This rule should be copied and customized for individual projects.
author: Cline (Originally based on general-workflow-guidelines.md)
version: 1.0
tags: ["git", "workflow", "branching-strategy", "version-control", "template", "common-rules"]
globs: ["*"] # This is a general template, applicable to any project context initially.
---
# Project Branching Strategy Template

This document outlines the general guidelines for the branching strategy recommended for individual development projects. Please copy this file into your project's `.clinerules` directory (e.g., `rules/YourProjectName/project-branching-strategy.md`) and customize it according to the specific needs and characteristics of your project.

## Branching Model for Development Projects

For individual development projects (e.g., ProjectA - a Laravel application):

*   The `.clinerules` for that project will be included as a Git submodule, tracking the corresponding project-specific rule branch from the main `clinerules` repository (e.g., `ProjectA`'s submodule tracks `clinerules/rules/projectA`).
*   Within the development project itself (e.g., ProjectA), a standard Gitflow-like or feature branch workflow is recommended:
    *   `main` or `master`: Production-ready code. This branch should always reflect a stable, releasable state.
    *   `develop`: Integration branch for features. All completed features are merged into this branch before being considered for a release. This branch should also aim to be stable.
    *   `feature/<feature-name>`: For new feature development. These branches are created from `develop` and merged back into `develop` upon completion.
        *   Example: `feature/user-authentication`, `feature/new-reporting-module`
    *   `bugfix/<bug-name>`: For fixing bugs found in `develop` or released versions (if not urgent). These branches are typically created from `develop` (or `main` if fixing a production bug that doesn't require an immediate hotfix) and merged back into `develop` (and potentially `main`).
        *   Example: `bugfix/login-error-on-safari`, `bugfix/incorrect-calculation-in-summary`
    *   `hotfix/<hotfix-name>`: For urgent production fixes. These branches are created from `main`, fixed, and then merged back into both `main` and `develop` (or the current release branch) to ensure the fix is incorporated into ongoing development.
        *   Example: `hotfix/critical-security-vulnerability`, `hotfix/data-corruption-issue`

**Note:** The specific names (`main` vs `master`, `develop` vs `development`) and the exact flow can be adapted based on team preference and project requirements. The key is to have a consistent and well-understood process.
