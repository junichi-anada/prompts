# Custom Rule Idea: Rule Sync Helper

**Date:** 2025-05-12

**Context:** Arising from the discussion about managing `.clinerules` across multiple projects using a central forked repository (`cline/prompts` fork) as a source. Manually copying rules can be tedious.

**Idea:**

Create a custom `.clinerule` that assists in synchronizing rule sets from the central source repository (specifically, the `upstream-sync` branch) to target projects.

**Potential Features:**

1.  **Define Rule Sets:** Allow defining named sets of rules (e.g., "web-dev-basics", "react-advanced") within the source repository (perhaps in a manifest file).
2.  **Target Project Specification:** The user specifies the target project directory path.
3.  **Rule Set Selection:** The user selects one or more predefined rule sets to sync.
4.  **Sync Execution:**
    *   The rule uses `execute_command` to run `cp` commands (or potentially `rsync` for more advanced diffing/syncing) to copy the selected rule files/directories from the source repository path (on the `upstream-sync` branch) to the target project's `.clinerules` directory.
    *   Could include options like `--overwrite` or `--dry-run`.
5.  **Difference Check (Advanced):** Potentially use `diff` command via `execute_command` to show differences before overwriting, or even attempt a basic merge for simple changes (though merging markdown might be complex).

**Benefits:**

*   Simplifies the process of applying common rule updates across multiple projects.
*   Reduces manual copy-pasting errors.
*   Encourages consistency in rule application.

**Implementation Notes:**

*   Would heavily rely on `execute_command` and require careful path handling (using absolute paths).
*   Error handling for file operations would be crucial.
*   Defining the "rule sets" would need a clear convention within the source repository.
