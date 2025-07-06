---
title: "Laravel 12 Coding Standards Best Practices"
description: "Guide to automatic PHP code formatting with Laravel Pint, recommended coding styles for Laravel projects, relationship with PSR-12, customization methods, and CI/CD integration!"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["Laravel", "Laravel12", "LaravelPint", "coding-standards", "best-practices", "PHP", "PSR-12", "コーディング規約", "ベストプラクティス"]
globs: ["*"]
---

### 🚀 What is Laravel Pint?

Laravel Pint is a magical tool that automatically cleans up your PHP code! ✨ Built on the famous "PHP-CS-Fixer" tool, it helps unify code style, making your code more readable and less bug-prone. It's designed for minimalists - simple and easy to use!

### 🛠️ Basic Usage of Pint

Using Pint is super simple!

1.  **Installation**: Add Pint to your Laravel project.
    ```bash
    composer require laravel/pint --dev
    ```
2.  **Execution**: To check and fix your code, just run this command!
    ```bash
    ./vendor/bin/pint
    ```
    This will automatically format your code to Laravel's standard style.

### 💖 What is Laravel's Default Style?

Pint automatically applies the coding style recommended for Laravel projects. This is primarily based on PSR-12 (PHP's standard convention), but Laravel has its own "Laravel" preset that creates more Laravel-specific code style.

For example, these rules are commonly applied:

*   **Indentation**: 4 spaces!
*   **Namespaces and use statements**: Organized and readable.
*   **Class/method declarations**: Proper visibility (`public`, `protected`, `private`) is specified.
*   **PHPDoc**: Comment formatting is also organized Laravel-style. There are specific rules for `@param` and `@return` formatting, so letting Pint handle it gives you peace of mind!

### 🎨 Customize to Your Preferences!

While Pint is plenty useful by default, you can create a `pint.json` file to customize rules to your or your team's preferences!

Create a `pint.json` file in your project's root directory and write configuration like this, and Pint will follow those settings:

```json
{
    "preset": "laravel",
    "rules": {
        "binary_operator_spaces": {
            "default": "single_space",
            "operators": {
                "=": null,
                "&": null,
                "|": null,
                "&&": null,
                "||": null
            }
        },
        "concat_space": {
            "spacing": "none"
        }
    }
}
```

This way, you can disable specific rules or fine-tune them, giving you complete control over your code style!

### 🤝 Relationship with PSR-12

Laravel Pint complies with PSR-12, PHP's official coding standard. So by using Pint, your Laravel project code becomes readable and standardized across the entire PHP community. Basic PSR-12 rules (file basics, line length, indentation, namespaces, class/method formatting, etc.) are automatically enforced by Pint, so you can focus on your code content!

### 💡 Best Practice Tips

*   **Integrate into CI/CD**: Set up automatic Pint execution before committing code to always maintain clean code. Setting it up with GitHub Actions is convenient!
*   **Run regularly**: After writing new code, make it a habit to run Pint frequently to keep your style consistent.
*   **Share with team**: When developing as a team, share the `pint.json` file to maintain the same coding style across everyone!

These guidelines will help you maintain consistent, high-quality Laravel code using Pint!
