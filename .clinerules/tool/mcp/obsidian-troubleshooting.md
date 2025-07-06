---
description: "Obsidian MCPサーバー利用時のトラブルシューティングガイド"
author: "Reco & Jun"
version: "1.0"
tags: ["mcp", "server", "obsidian", "troubleshooting"]
globs: ["*"]
---
# Obsidian MCPサーバー トラブルシューティング

## `obsidian_patch_content` が `invalid-target` で失敗する場合

`patch`（部分的な書き換え）がうまくいかない場合、無理に原因を追求するより、代替手段を使うのが早いことが多いよ！

-   **代替手段**: `obsidian_put_content` を使って、ファイル全体をまるごと上書きする。
-   **手順**:
    1.  `obsidian_get_file_contents` で現在のファイル内容を正確に取得する。
    2.  取得した内容を元に、修正したい箇所だけ変更した新しいコンテンツを作る。
    3.  `obsidian_put_content` で、新しいコンテンツをファイルに書き込む。

## `obsidian_list_files_in_dir` が `Not Found` を返す場合

指定したディレクトリが存在するはずなのに `Not Found` エラーが出る場合、そのディレクトリが空っぽの可能性があるよ。

-   **原因**: ObsidianのAPIは、空のディレクトリを「存在しない」ものとして扱うことがある。
-   **対処法**:
    -   慌てずに、そのディレクトリにファイルを作成する処理（例: `obsidian_put_content`）を実行してみる。
    -   ファイルが作成されれば、ディレクトリも自動的に認識されるようになるはずだよ！
