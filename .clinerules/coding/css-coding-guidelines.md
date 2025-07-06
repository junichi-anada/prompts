---
title: "CSS Coding Standards Best Practices"
description: "Essential best practices for writing CSS styles! Following these guidelines makes your code more readable, easier to maintain, and enables smoother collaborative development! 🚀"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["CSS", "coding-standards", "best-practices", "web-development", "stylesheets", "コーディング規約", "ベストプラクティス", "ウェブ開発", "スタイルシート"]
globs: ["*"]
---

# 🎨 CSS Coding Standards Best Practices ✨

These are essential best practices for writing CSS styles! Following these guidelines makes your code more readable, easier to maintain, and enables smoother collaborative development! 🚀

## 1. Stylesheet Structure and Organization 📚

*   **Organization is key!**
    *   Separating CSS files by role keeps things tidy! For example, basic styles in `base.css`, layout in `layout.css`, component styles in `components.css`.
    *   If you can't separate files, group related styles together and add comment headers like "Header styles here!" to make it easier to understand later! 👀
*   **Always use the same approach!**
    *   Unify indentation methods, class naming conventions, and comment writing styles across the entire project. Inconsistency makes code hard to read! 🙅‍♀️
*   **Readability first!**
    *   Write CSS properties (like `color: red;`) one per line for better readability!
    *   Add blank lines between selectors (like `body` or `.button`) and their content (`{ ... }`) for better visibility! 👍

## 2. Style Definition Location 📍

*   **External files are the foundation!**
    *   Creating separate `.css` files from HTML files is the best approach! This makes maintenance easier and speeds up website loading! 💨
*   **Use `<style>` tags occasionally!**
    *   Only for page-specific styles with small amounts of code, writing directly in HTML `<head>` with `<style>` tags is acceptable.
*   **Avoid inline styles!**
    *   Writing `style="color: blue;"` directly in HTML tags isn't ideal. It makes changes difficult later and prevents style reuse. 💦

## 3. Selectors 🎯

*   **Simple is best!**
    *   Avoid long, specific selectors like `#sidebar #main-nav ul li a`. Tight coupling to HTML structure can break CSS with minor HTML changes. 😱
    *   Keep selectors short and focus on class names (like `.button`) for styling!
*   **Use ID selectors carefully!**
    *   ID selectors (like `#header`) have strong specificity, making it difficult to override other styles. Avoid overusing them for styling except when needed for JavaScript functionality.
*   **Don't write unnecessary parts!**
    *   Instead of `body .container .classname li`, often `.classname li` is sufficient. Keep it simple! ✨
*   **Understand specificity!**
    *   When wondering "Why isn't this style working?", selector "specificity" might be the cause! Understanding the rules for which styles take priority saves you from confusion. 🤔

## 4. Naming Conventions 🏷️

*   **Unify naming approaches!**
    *   Using naming conventions like BEM (Block, Element, Modifier) or SMACSS makes it easy to understand "What role does this component play?" just by looking at class names. Follow team-agreed rules for clear naming!
*   **Use lowercase and hyphens!**
    *   Write class names and ID names in all lowercase, connecting words with hyphens (`-`). Avoid using underscores (`_`).

## 5. Properties and Values 🌈

*   **Establish property order rules!**
    *   Unifying the order of CSS properties (like `width`, `height`, `color`) makes them easier to find later and improves code readability. Try alphabetical order or layout-related properties first - decide as a team!
*   **Use shorthand properties wisely!**
    *   Properties like `margin`, `padding`, `font`, `background`, `border` can be written together using "shorthand properties" to reduce code volume! However, when you only want to change part of it, writing individually is fine too!
*   **Don't forget units!**
    *   For `0` values, you can omit units (like `0px`), but always include units for other values.
*   **Unify color specifications!**
    *   Unify color writing methods like `#RRGGBB` or `rgb()` across the project. If you can use the short `#RGB` format, it keeps code cleaner!
*   **`!important` is a last resort!**
    *   `!important` is a magic word that overrides any style, but overusing it makes later style modifications extremely difficult, so avoid it except when truly necessary! 🙅‍♀️

## 6. Comments 💬

*   **Comment unclear sections!**
    *   For complex CSS or code written for specific reasons, leaving comments helps you and others understand "Ah, I see!" when reviewing later.
    *   Adding section divider comments like "Header styles start here!" makes the overall structure easier to grasp.
    *   However, simple code that anyone can understand doesn't need comments. Keep it simple!
*   **Unify comment writing styles!**
    *   Standardizing multi-line comment formatting across the team makes the appearance cleaner.

    ```css
    /* ==========================================================================
       Header ✨
       ========================================================================== */
    .header {
        /* Header styles go here! */
    }

    /* Note: This style is needed for a special reason! */
    .special-case {
        color: red; /* Made red for urgency! 🚨 */
    }
    ```

## 7. Media Queries 📱💻

*   **Mobile first or desktop first?**
    *   When creating responsive design (designs that look good on both mobile and PC), decide whether to take a "mobile-first" (design from mobile) or "desktop-first" (design from PC) approach.
*   **Flexible breakpoints!**
    *   Breakpoints ("change layout at this screen width") should be set where content breaks or where you want to change layout, rather than matching specific device sizes.
*   **Unify media query placement!**
    *   Decide whether to write them immediately after related components or gather them at the end of CSS files. Using tools like Sass makes writing per-component easier!
*   **Indent media query contents too!**

## 8. Performance and Maintainability ⚡️

*   **Remove unnecessary CSS!**
    *   Regularly review and remove unused styles and duplicate styles. This makes code lighter!
*   **Make CSS files smaller!**
    *   When publishing websites, compressing (minifying) CSS files reduces file size and speeds up page loading! 🚀
*   **Try useful tools!**
    *   Using "CSS preprocessors" or "post-processors" like Sass, Less, or PostCSS lets you use variables and write styles more efficiently, making CSS writing more productive!
*   **Watch out for excessive nesting!**
    *   Especially when using preprocessors, deeply nesting styles can make output CSS longer, so be careful.

## 9. Other Considerations 💡

*   **Automate vendor prefixes!**
    *   "Vendor prefixes" like `-webkit-` or `-moz-` can be automatically added using tools like Autoprefixer - very convenient! Manual work is tedious.
*   **Try CSS validators!**
    *   Use tools like W3C CSS Validation Service to check your CSS for errors! You can verify there are no issues.
*   **Design for everyone!**
    *   Ensure good color contrast, make keyboard navigation clear, and consider accessibility (usability) in your styling.

These best practices are tips for improving your CSS code! Flexibly adopt them based on project scale, team methods, and technologies used. Most importantly, follow the same rules as a team and write consistent code! 😊
