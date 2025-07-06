---
description: Defines the protocol for creating appendix files to document proposed improvements to other .clinerules, especially in forked repositories, avoiding direct modification conflicts.
author: Jun-san
version: 1.0
tags: ["meta", "メタ", "clinerules", "クラインルール", "improvement", "改善", "documentation", "ドキュメント", "protocol", "プロトコル", "fork-management", "フォーク管理"]
globs: ["*"] # Applies generally when rule improvement is considered
---

# Rule Improvement Appendix Protocol

## Objective

This protocol defines a standardized method for documenting proposed improvements to existing `.clinerules` by creating separate "appendix" files. This approach is particularly useful in forked repositories (like this one, tracking `cline/prompts`) where direct modification of synced rules might cause conflicts with upstream updates. It provides a safe space to record suggestions identified during the reflection process (e.g., triggered by `self-improving-cline.md`).

## Context / Trigger

This protocol should be considered during the reflection phase described in `self-improving-cline.md`, specifically when:

1.  A potential improvement to an existing rule (let's call it `original-rule.md`) is identified.
2.  The context suggests that directly modifying `original-rule.md` is undesirable (e.g., risk of upstream conflicts, need for further discussion).

## Workflow

When the above conditions are met, follow these steps to create or update an appendix file:

1.  **Identify Target Directory:**
    *   The designated directory for appendix files is `.clinerules/optional/`.
    *   *Note: The `write_to_file` tool will create this directory if it doesn't exist.*

2.  **Determine Appendix Filename:**
    *   The filename follows the pattern: `appendix-{original_filename}.md`.
    *   Example: If improving `self-improving-cline.md`, the appendix file is `.clinerules/optional/appendix-self-improving-cline.md`.

3.  **Draft Appendix Content:**
    *   **Metadata (Frontmatter):** Each appendix file MUST include its own YAML frontmatter with at least `description`, `author`, `version`, and relevant `tags`. The description should clearly state it's an appendix for the original rule.
    *   **Reference:** Clearly state which original rule file this appendix relates to.
    *   **Proposed Change:** Describe the suggested improvement. Use a clear format, such as:
        *   "The original rule (`original-rule.md`) currently states: [Quote or summary of relevant part]."
        *   "Proposed Change: [Describe the suggested modification, e.g., change X to Y, add section Z]."
        *   Use Markdown diff code blocks (```diff ... ```) where helpful to illustrate specific changes.

4.  **Create/Update File:**
    *   Use the `write_to_file` tool to create or overwrite the appendix file at the determined path (`./.clinerules/optional/appendix-{original_filename}.md`) with the drafted content (including frontmatter).

## Example Appendix File Structure

```markdown
---
description: Appendix proposing improvements to example-rule.md regarding error handling.
author: Cline
version: 1.0
tags: ["appendix", "suggestion", "error-handling"]
---

# Appendix for: example-rule.md

This appendix proposes changes to the error handling section of `example-rule.md`.

**Original Rule Section:**
> Handle errors by logging them to the console.

**Proposed Change:**
> Enhance error handling:
> ```diff
> - Handle errors by logging them to the console.
> + Handle errors by:
> + 1. Logging detailed error information (including stack trace) to the console.
> + 2. Attempting a graceful recovery or fallback mechanism if possible.
> + 3. Notifying the user with a clear, user-friendly message.
> ```
> *Rationale: Provides more robust error management and better user experience.*
```

## Relationship to `self-improving-cline.md`

This protocol serves as a specific implementation pathway for the "Assess Context & Conflict Risk" step suggested in `appendix-self-improving-cline.md`. When direct modification is deemed risky, `self-improving-cline.md` can trigger this protocol to document the suggestion instead.

## Implementation Notes

1. **Directory Structure**
   * `.clinerules/optional/` is used to clearly separate appendix files from core rules
   * This structure allows for easy identification of improvement suggestions
   * Prevents confusion with original rule files

2. **Filename Convention**
   * The `appendix-` prefix clearly identifies the file's purpose
   * Using the original filename maintains clear relationship to source
   * `.md` extension maintains consistency with other rule files

3. **Content Format**
   * Clear separation between original content and proposed changes
   * Use of diff blocks for precise change visualization
   * Required metadata ensures proper documentation
