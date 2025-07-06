---
title: "HTML5 Coding Standards Best Practices"
description: "Essential rules for creating web pages with HTML5 - keep your code clean, make it accessible to everyone, and optimize for search engines!"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["HTML5", "coding-standards", "best-practices", "web-development", "コーディング規約", "ベストプラクティス", "ウェブ開発"]
globs: ["*"]
---

### HTML5 Coding Standards Best Practices (Recommended Points! ✨)

Essential rules for creating web pages with HTML5 - keep your code clean, make it accessible to everyone, and optimize for search engines!

---

#### 1. Document Preparation Basics! 📄

*   **Always write `<!DOCTYPE html>`!**
    *   This is like telling the computer "This file is HTML5!" Write it at the very beginning.
*   **Set character encoding to `UTF-8`!**
    *   To properly display Japanese, English, and characters from various countries, write `<meta charset="UTF-8">` in the `<head>` section.
*   **Specify the page language!**
    *   Writing `lang="ja"` in the `<html>` tag helps search engines and screen readers understand "This page is in Japanese!"

#### 2. Page Layout Magic ✨

*   **Don't forget mobile-friendly settings!**
    *   Writing `<meta name="viewport" content="width=device-width, initial-scale=1.0">` in the `<head>` makes the page automatically adjust to mobile screen sizes.

#### 3. Use Meaningful Tags! 💡

*   **Tags have specific meanings!**
    *   Use content-appropriate tags like `header` (page header), `nav` (navigation menu), `main` (main content), `article` (article), `section` (section), `aside` (sidebar content), `footer` (page footer) to help both computers and humans understand page structure.
    *   Use headings `<h1>` through `<h6>` in proper order!
*   **Use `<div>` and `<span>` only when no other suitable tag exists!**
    *   These are "generic containers," so use semantic tags when you want to convey meaning.

#### 4. Tips for Writing Clean Code 🧼

*   **Keep indentation consistent!**
    *   Decide as a team whether to use 2 or 4 spaces, or tabs, for consistent, readable code.
*   **Add blank lines between important blocks!**
    *   This makes code groupings clearer and more readable.
*   **Write tag names and attribute names in lowercase!**
    *   While HTML5 works with uppercase, using lowercase is cleaner and reduces errors.
*   **Wrap attribute values in double quotes!**
    *   Like `<input type="text" value="hello">`.
*   **Add comments only where necessary!**
    *   Use them when thinking "This is a bit complex, let me explain!" - they'll be helpful later.

#### 5. Images and Links Considerations 🖼️🔗

*   **Always add `alt` attributes to images!**
    *   Like `<img src="cat.jpg" alt="cute cat photo">`, include text describing the image content. This helps people understand what the photo shows even when images can't be seen.
*   **Make link text descriptive!**
    *   Instead of "click here," write "view product details" to clearly indicate the link destination.
*   **Use `target="_blank"` and `rel="noopener noreferrer"` together for external links!**
    *   When opening in new tabs, using these two together is recommended for security and performance.

#### 6. Loading CSS and JavaScript 🚀

*   **Load CSS in the `<head>` section!**
    *   Writing `<link rel="stylesheet" href="style.css">` applies styles before page display, preventing layout flash.
*   **Load JavaScript just before `</body>`!**
    *   Writing `<script src="script.js"></script>` there makes JavaScript run after HTML loading completes, speeding up page display.

#### 7. Make Forms User-Friendly! 📝

*   **Add `label` elements to input fields!**
    *   Like `<label for="name">Name:</label><input type="text" id="name">`, make it clear what each input field is for.
*   **Choose correct input types!**
    *   Specifying `type="email"` for email addresses or `type="tel"` for phone numbers makes mobile input easier.

#### 8. Final Check! ✅

*   **Use W3C validator to check for errors!**
    *   This tool checks HTML syntax. Verify there are no errors to aim for high-quality code.