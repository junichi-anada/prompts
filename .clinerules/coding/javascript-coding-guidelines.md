---
title: "JavaScript Coding Standards Best Practices"
description: "Best practices for JavaScript coding standards in ES6+ development. Guidelines focusing on Prettier integration, readability, performance, and maintainability!"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["JavaScript", "ES6", "coding-standards", "best-practices", "Prettier", "ESLint", "TypeScript", "コーディング規約", "ベストプラクティス"]
globs: ["*"]
---

## Brief overview
This guideline compiles best practices for JavaScript coding standards in ES6+ development. It focuses on Prettier integration, readability, performance, and maintainability!

## Prettier Integration and Basic Formatting Rules
- **Automatic formatting with Prettier!** ✨
  - By letting Prettier handle code appearance, you can maintain consistent style across the entire team. You don't have to worry about manual formatting, so you can focus on development!
  - Adding Prettier configuration to `package.json` or integrating it into CI/CD makes it even more convenient.
- **Basic Formatting Rules**
  - **Indentation**: 2 or 4 spaces (follow project conventions). Prettier handles this automatically, so you don't need to worry about it!
  - **Quotes**: Unify on either single quotes (`'`) or double quotes (`"`). This can be set in Prettier configuration.
  - **Semicolons**: Whether to add semicolons at line ends (`semi: true` or `semi: false`). Leave this to Prettier too!
  - **Line Length**: Lines that are too long are hard to read, so break them at appropriate lengths. Prettier adjusts this automatically.

## Standards for Improving Readability
- **Naming conventions are super important!** 🌟
  - **Variables & Functions**: Use `camelCase` (e.g., `getUserData`, `totalCount`) for readability.
  - **Classes**: Use `PascalCase` (e.g., `UserService`, `ProductModel`) to immediately identify classes.
  - **Constants**: Use all uppercase with underscore separation (e.g., `MAX_ITEMS`, `API_KEY`) to clearly identify constants.
  - **Meaningful names**: Avoid meaningless names like `a`, `b`, `temp` - use names that clearly indicate what they represent!
- **Explain code with comments!** 📝
  - **JSDoc**: Writing function and class purposes, parameters, return values, etc., in JSDoc format serves as documentation and enables IDE completion.
  - **Explain the why**: Comments that explain "why you're doing this" rather than "what you're doing" are incredibly helpful when reviewing code later.
- **Code structuring and modularization** 📦
  - **ES Modules**: Use `import` and `export` to split functionality into small files. This clarifies dependencies and improves code visibility.
  - **Single Responsibility Principle**: Design functions and modules to handle only one thing - this makes changes and testing easier.
  - **Helper function separation**: Even in small projects, collect general-purpose helper functions (like `zenkakuToHankaku`) into dedicated files like `utils.js` and import them as modules! This improves code reusability and visibility.
- **Early returns and guard clauses** 🛡️
  - When there are errors or invalid inputs in conditional branches, using "early returns" to immediately terminate processing prevents deep nesting and makes code more readable.

## Standards for Performance Optimization
- **Minimize DOM manipulation!** 🚀
  - DOM manipulation is expensive, so batch operations together. For example, instead of adding DOM elements multiple times in a loop, add them all at once for efficiency.
  - **Event delegation**: Instead of setting event listeners on many elements, set one on the parent element and identify the event source.
- **Loop processing optimization** ⚡
  - Use appropriate loops like `for...of` or `forEach` for the purpose. For large-scale data processing, `for` loops may be fastest.
- **Proper use of asynchronous processing** ⏳
  - **Promise, async/await**: Execute time-consuming processes (API calls, file reading, etc.) asynchronously to prevent UI freezing. Using `async/await` makes asynchronous processing written synchronously and more readable.
- **Dead code elimination and bundle size optimization** 🗑️
  - Remove unused code. Using bundlers like Webpack or Rollup can automatically remove unnecessary code (tree shaking) to reduce final file size.

## Standards for Improving Maintainability
- **Check code quality with ESLint!** ✅
  - While Prettier formats code appearance, ESLint finds potential bugs and anti-patterns in code. Using Prettier and ESLint together is the ultimate combination!
  - **Avoiding conflicts**: Use plugins like `eslint-config-prettier` to prevent Prettier and ESLint settings from conflicting.
- **Always write test code!** 🧪
  - **Unit tests**: Tests that verify individual functions or components work correctly.
  - **Integration tests**: Tests that verify multiple components or modules work together correctly.
  - Writing tests allows you to verify that future changes don't affect existing functionality, and improves code design.
- **Unified error handling** 🚨
  - Having unified approaches to error handling makes debugging easier. Proper use of `try...catch` blocks or defining custom error classes works well.
- **Dependency management** 🌳
  - Clearly define dependencies in `package.json` and manage versions properly. Using package managers like `npm` or `yarn` appropriately makes project setup easier.
- **Type checking introduction (TypeScript)** 💡
  - If you're interested, introducing TypeScript adds type safety to JavaScript, dramatically improving maintainability in large projects. You can find errors at compile time, reducing runtime errors.

## Utilizing ES6+ Features
- **Proper use of `const` and `let`** 🔄
  - **`const`**: Use `const` for variables that won't be reassigned. This prevents unintended changes.
  - **`let`**: Use `let` for variables that need reassignment.
  - **Don't use `var`!**: `var` has many problems like lacking block scope, so avoid using it generally.
- **Arrow functions** =>
  - They're concise and have clear `this` behavior, so use them actively for callback functions.
- **Destructuring assignment** 💥
  - Using this when extracting values from objects or arrays makes code cleaner.
- **Spread syntax** ...
  - Using this for array merging, object copying, function arguments, etc., creates convenient and readable code.
- **Template literals** `` ` ``
  - Using this to embed variables or expressions in strings makes string concatenation easier and handles multi-line strings better.
- **Class syntax** 🏛️
  - Using this for object-oriented code makes structure clearer. It also enables inheritance and encapsulation.

I hope these guidelines help with your JavaScript development! Feel free to ask if you have questions or want additions!