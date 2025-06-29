---
title: "GitHub Actions Rules"
description: "GitHub Actionsのワークフローにおけるツール実行パスの指定や、CI/CD環境での一貫した実行を保証するためのルールをまとめたよ！"
author: "Reco"
date: "2025-06-03"
tag: ["GitHub Actions", "CI/CD", "ベストプラクティス", "ワークフロー"]
globs: *
---

# GitHub Actions Rules

## Tool Execution Path

*   **Rule:** When executing tools located in the `vendor/bin` directory (e.g., PHPStan, PHPUnit) within a GitHub Actions workflow, explicitly specify the execution path using `./vendor/bin/<tool_name>`.
*   **Reason:** This prevents potential path resolution issues that can occur in CI/CD environments, ensuring consistent and reliable execution.
*   **Example:** Instead of `phpstan analyse`, use `./vendor/bin/phpstan analyse`.
