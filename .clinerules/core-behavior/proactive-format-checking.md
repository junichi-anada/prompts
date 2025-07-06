---
description: "Rules for proactively checking existing file formats before creating new files to maintain consistency."
author: "Reco"
version: "1.0"
tags: ["core-behavior", "コア動作", "consistency", "一貫性", "file-format", "ファイル形式"]
globs: ["*"]
---
# ✨ Proactive File Format Checking Rules ✨

## Purpose
Rules for checking existing rules and formats before creating new files to maintain consistency and reduce mistakes!

## When to activate
This activates when asked to create new files like reports, task notes, or source code, especially when similar files already exist in the same directory.

## Action checklist
1.  **Look for similar files!** 🧐
    Before creating a new file, search the same directory or parent directories for files with similar purposes. (e.g., other `.md` reports, other `.js` components, etc.)

2.  **Mimic the format!** 📝
    If similar files are found, read one or two to understand the writing rules.
    *   **Metadata**: Check if there are sections with file information like YAML frontmatter.
    *   **Structure**: Check for commonly used heading structures, sections, and standard text patterns.
    *   **Naming conventions**: See how similar files are named.
    *   **Coding style**: For source code, if there's no clear style guide, infer the style from existing code.
    *   **Associations**: Check how files are linked to each other (e.g., whether daily reports link to projects or vice versa).

3.  **Ask Jun if unsure!** 🙋‍♀️
    If the format is clear, use it to create the file. If the rules are unclear or there are multiple rules causing confusion, consult Jun before creating, like "There seem to be two types of report formats, which one should I use?"

4.  **Create the new file!** 🚀
    Create the new file using the confirmed or instructed format!