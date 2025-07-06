---
title: "GitHub Actions Rules"
description: "Rules for specifying tool execution paths in GitHub Actions workflows and ensuring consistent execution in CI/CD environments!"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["GitHub Actions", "CI/CD", "best-practices", "ベストプラクティス", "workflow", "ワークフロー"]
globs: ["*"]
---

# GitHub Actions Rules

## Tool Execution Path

*   **Rule:** When executing tools located in the `vendor/bin` directory (e.g., PHPStan, PHPUnit) within a GitHub Actions workflow, explicitly specify the execution path using `./vendor/bin/<tool_name>`.
*   **Reason:** This prevents potential path resolution issues that can occur in CI/CD environments, ensuring consistent and reliable execution.
*   **Example:** Instead of `phpstan analyse`, use `./vendor/bin/phpstan analyse`.
