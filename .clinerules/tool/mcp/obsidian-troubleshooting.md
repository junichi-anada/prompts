---
description: "Troubleshooting guide for Obsidian MCP server usage"
author: "Reco & Jun"
version: "1.1"
tags: ["mcp", "server", "obsidian", "troubleshooting", "トラブルシューティング"]
globs: ["*"]
---
# Obsidian MCP Server Troubleshooting

## Effective Usage of `obsidian_patch_content`

### When Failing with `invalid-target`

When `patch` (partial rewriting) doesn't work well, it's often faster to use alternative methods rather than struggling to find the cause!

-   **Alternative Method**: Use `obsidian_put_content` to overwrite the entire file.
-   **Steps**:
    1.  Get the current file content accurately with `obsidian_get_file_contents`.
    2.  Create new content based on the retrieved content, changing only the parts you want to modify.
    3.  Write the new content to the file with `obsidian_put_content`.

### Reliable Line Editing Using Block IDs

Using `target_type: "block"` allows you to edit specific lines with pinpoint accuracy - super convenient!

-   **How to Use**:
    1.  Beforehand, add a unique ID at the end of the line you want to edit in the format `^blockID`.
    2.  When calling `obsidian_patch_content`, specify `"block"` for `target_type`.
    3.  For `target`, specify the block ID string **without** the `^` (e.g., `"blockID"`).
-   **Key Point**: With this method, you can accurately target and edit lines with IDs even if other parts of the file change, making it super stable! 👍

## When `obsidian_list_files_in_dir` Returns `Not Found`

If you get a `Not Found` error even though the specified directory should exist, the directory might be empty.

-   **Cause**: Obsidian's API sometimes treats empty directories as "non-existent".
-   **Solution**:
    -   Don't panic - try executing a process to create a file in that directory (e.g., `obsidian_put_content`).
    -   Once a file is created, the directory should be automatically recognized!
