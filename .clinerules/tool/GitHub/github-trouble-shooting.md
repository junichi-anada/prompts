---
description: "GitHubのMCPサーバー利用時のトラブルシューティング"
author: "Reco & Jun"
version: "1.0"
tags: ["mcp", "server", "github", "troubleshooting"]
globs: ["*"]
---
# GitHub MCPサーバー トラブルシューティング

## `Authentication Failed` / `Bad credentials` エラー

GitHubのMCPサーバーで認証エラーが出た場合は、認証情報（Personal Access Tokenなど）が間違っているか、有効期限が切れている可能性が高いです。

**ユーザーに**以下の点を確認してもらうよう依頼してください:

1.  **トークンの有効期限**: GitHubのトークンが有効期限切れになっていないか確認する。
2.  **必要な権限（スコープ）**: トークンに `repo` や `workflow` など、実行したい操作に必要な権限が付与されているか確認する。
3.  **設定の確認**: `cline_mcp_settings.json` などの設定ファイルに、トークンが正しく設定されているか確認する。

ユーザーがトークンを更新・修正したら、MCPサーバーの再起動を試してもらうよう伝えてください。
