---
title: "TailwindCSS Coding Standards"
description: "Coding standards for effective use of TailwindCSS in this project!"
author: "Reco"
version: "1.0"
date: "2025-07-02"
tags: ["TailwindCSS", "coding-standards", "best-practices", "CSS", "コーディング規約", "ベストプラクティス"]
globs: ["*.php", "*.html", "*.js"]
---

# 🎨 TailwindCSS Coding Standards ✨

These rules will help you use TailwindCSS effectively and efficiently in this project! Following these guidelines will make your code cleaner and more understandable! 🚀

### 1. Introduction: Go Utility-First! 🚀

The foundation is the "utility-first" approach - write utility classes directly in HTML `class` attributes! Use custom CSS files like `style.css` only as a "last resort" when absolutely necessary.

### 2. Class Order: Write in Visual Order for Clarity!

While there's no strict rule for class order, maintaining consistency dramatically improves readability! Here's the recommended order:

1.  **Layout & Positioning** (`position`, `top`, `flex`, `grid`, `block`...)
2.  **Box Model** (`w`, `h`, `p`, `m`, `border`...)
3.  **Typography** (`font-size`, `font-weight`, `text-align`, `color`...)
4.  **Background** (`bg-color`, `bg-image`...)
5.  **Other** (`rounded`, `shadow`, `opacity`, `transition`...)
6.  **State** (`hover:`, `focus:`...)

**Good Example:**
```html
<button class="flex items-center p-4 m-2 text-lg font-bold text-white bg-blue-500 rounded hover:bg-blue-600">
  Click me
</button>
```

### 3. Responsive Design: Think Mobile First! 📱

Follow the "mobile-first" approach for styling! Start with mobile appearance, then use prefixes like `md:` and `lg:` to override for tablet and desktop displays.

**Good Example:**
```html
<!-- Stacked on mobile, horizontal on md+ screens -->
<div class="flex flex-col md:flex-row">
  <!-- ... -->
</div>
```

### 4. State Styling ✨

Interactive styles are easily implemented by adding prefixes like `hover:`, `focus:`, `active:`, `disabled:` to class names!

When you want to change child element styles based on parent state, add the `group` class to the parent and use `group-hover:` on child elements. Super convenient!

**Good Example:**
```html
<a href="#" class="group block p-4 bg-white rounded-lg hover:bg-blue-100">
  <p class="font-bold group-hover:text-blue-600">Title</p>
  <p class="text-sm">Details here...</p>
</a>
```

### 5. Rules for Using `style.css` 🤝

While custom CSS should be avoided, sometimes it's necessary. Follow these rules when you must use it!

-   **When to use:**
    1.  Complex styles that are difficult to express with Tailwind alone (e.g., `::before` or `::after`, complex animations).
    2.  Emergency fallback when specific utilities don't work in CDN environments.
-   **How to write:**
    -   Use specific selectors with IDs (like `#region`) or specific class names to avoid affecting other areas.

### 6. Component-like Patterns in PHP 🧩

Since this project uses PHP without React-like components, when the same visual components (buttons, cards, etc.) appear multiple times, actively reuse them!

-   Extract into PHP functions.
-   Separate into files like `footer.html` and `include` them.

This reduces code duplication and makes maintenance easier!

### 7. Caution When Manipulating Classes with JavaScript ⚠️

This was a key learning point!

CDN version of Tailwind **only generates CSS for class names written in HTML files**. So if you add classes with JavaScript like `classList.add('bg-red-500')`, but that class isn't written anywhere in the HTML, the styles won't be applied.

-   **Solution 1 (Recommended):** Like with tabs, only toggle state classes like `active` with JS, and write specific styles in `style.css`.
-   **Solution 2:** If you absolutely need to manipulate Tailwind classes with JS, you might need hacks like commenting out class names somewhere in the HTML. (But this isn't really recommended!)

Follow these rules for enjoyable coding! Feel free to ask anytime if you have questions! 😊
