---
description: Update rules to the .clinerules folder via Pull Request
author: Jun
version: 1.0
tags: ["workflow", "planning", "execution", "documentation", "obsidian"]
globs: ["**/*.md", "workflows/**/*"]
---
# Workflow: update-rules

## COMMAND
/update-rules

## IMPORTANT
- **このコマンドはACTモードでのみ使用します。**
- **PLANモードの時は、ACTモードに切り替えるようにユーザーに促してください。**
- **このコマンド実行時は、Obsidianを使いません。**

## About
- .clinerulesフォルダのファイルをGitHubリポジトリにPull Requestでアップロードします。

## WORKFLOW
1.  GitHubリポジトリ[https://github.com/junichi-anada/prompts/tree/my-rules]の`README.md`を参照する。
2.  `README.md`の「3. プロジェクトからのルール更新 (PR経由)」の手順に従って、プルリクエストを作成する。
3.  プルリクエストの作成が完了したら、その旨をユーザーに通知する。

## ERROR HANDLING
- Gitの認証エラーが発生した場合は、GitHubの認証情報の確認を促す。
- ブランチの作成に失敗した場合は、エラーメッセージを表示する。
- プッシュに失敗した場合は、ネットワーク接続の確認を促す。
- Pull Requestの作成に失敗した場合は、手動での作成を促す。
