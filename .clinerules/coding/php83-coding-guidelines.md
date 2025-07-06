---
title: "PHP 8.3 Coding Standards Best Practices"
description: "A comprehensive guide to PHP 8.3 coding standards based on PHP-FIG's PSR-1 and PSR-12, presented in an easy-to-understand format!"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["PHP", "PHP83", "coding-standards", "best-practices", "PSR-1", "PSR-12", "コーディング規約", "ベストプラクティス"]
globs: ["*"]
---

**PHP 8.3 Coding Standards Best Practices ✨**

This guide provides a comprehensive overview of PHP 8.3 coding standards based on PHP-FIG's PSR-1 and PSR-12. Following these guidelines will help you write clean, maintainable PHP code!

### 1. Follow PSR-1 and PSR-12 as Foundation! 📝

The foundation of PHP coding standards is the PSR (PHP Standard Recommendations) defined by PHP-FIG. PSR-1 (Basic Coding Standard) and PSR-12 (Extended Coding Style Guide) are particularly important. PSR-12 is an evolution of PSR-2 that supports newer PHP features, making it perfect for PHP 8.3 development!

### 2. File Structure Rules! 📁

*   **Use LF (Line Feed) for line endings only!** Follow Unix-style line endings.
*   **End files with a blank line!** This is an important rule for consistency.
*   **Omit closing tags `?>` in PHP-only files!** This prevents unwanted whitespace issues.

### 3. Code Writing Guidelines! 💡

*   **Keep line length within 120 characters!** When exceeding 80 characters, consider breaking into multiple lines for better readability.
*   **No trailing whitespace at line ends!** This is often overlooked but important for clean code.
*   **Use 4 spaces for indentation! Don't use tabs!** This keeps code formatting consistent.
*   **Write keywords and types in lowercase!** Use short forms like `bool` instead of `boolean`, `int` instead of `integer`.

### 4. Namespace and Use Statement Organization! 🧼

*   File header should follow this order: `<?php` tag, file-level DocBlock, `declare` statement, `namespace` declaration, `use` statements.
*   Group `use` statements by type: classes, functions, constants - without blank lines between statements in each group.
*   When using aliases with `use` statements, you can write: `use Vendor\Package\{ClassA as A, ClassB};`

### 5. Classes, Properties, and Methods! 👩‍💻

*   **Opening braces `{` for classes, interfaces, and traits go on the next line!** Closing braces `}` also go on their own line.
*   **Always declare visibility (`public`, `protected`, `private`) for properties!** Since PHP 7.1, constants can also have visibility.
*   **Don't prefix property names with underscore `_`!** Use visibility keywords instead.
*   **Always declare visibility for methods!** No space between method name and opening parenthesis.
*   **No space before commas in argument lists, one space after!** Place default-value arguments at the end of the list.
*   For multiple arguments, consider placing each on its own line for better readability.

### 6. Control Structures (if, switch, for, etc.)! 🚦

*   Control structures like `if`, `switch`, `for`, `foreach`, `while`, `do while`, `try-catch-finally` follow this pattern: keyword + one space + opening parenthesis (no space after) + closing parenthesis (no space before) + one space + opening brace `{`.
*   Always wrap the body in braces `{}` with proper indentation.
*   Use `elseif` instead of `else if`.

### 7. Operator Usage! 🧮

*   Unary operators (`++`, `--`, etc.) have no space between operator and operand.
*   Type casting (`(int)`, etc.) has no space inside parentheses.
*   Binary operators (`+`, `-`, `==`, `===`, `&&`, `||`, etc.) have at least one space before and after.
*   Ternary operators (`? :`) have spaces before and after both `?` and `:`.

### 8. Closures and Anonymous Classes! 👻

*   Closures have a space after the `function` keyword and spaces before and after the `use` keyword.
*   Opening brace `{` goes on the same line, closing brace `}` goes on the next line.
*   Anonymous classes follow the same rules as closures.

With these PHP 8.3 coding standards, you'll be writing clean, professional PHP code! Feel free to ask if you have any questions!