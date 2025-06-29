# My Prompts Rule Source (cline/promptsのフォーク)

このリポジトリは、オリジナルの [cline/prompts](https://github.com/cline/prompts.git) リポジトリのフォークです。

## 目的

このフォークの主な目的は、Jun様のカスタム`.clinerules`のソースとして機能し、他のプロジェクトに選択的にコピーできるようにすることです。また、このフォークのメインブランチを直接変更することなく、アップストリームの`cline/prompts`リポジトリから最新のルールを同期することも可能です。

## ワークフロー

### 1. アップストリームとの同期

オリジナルの`cline/prompts`リポジトリから最新のルールを取得するには、以下の手順を実行します。

1.  `upstream`リモートが設定されていることを確認します。
    ```bash
    git remote add upstream https://github.com/cline/prompts.git
    # (既に存在する場合、このコマンドは通知します)
    ```
2.  `main`ブランチにチェックアウトします。
    ```bash
    git checkout main
    ```
3.  アップストリームリポジトリから最新の変更をフェッチしてマージします。
    ```bash
    git fetch upstream
    git merge upstream/main # またはアップストリームの関連ブランチ
    # 必要に応じて競合を解決します
    ```
    これで、`main`ブランチには`cline/prompts`からの最新のルールが含まれます。

### 2. ルールをプロジェクトに適用する

このリポジトリは、Jun様のプロジェクトでClineの動作をカスタマイズするための`.clinerules`を管理しています。`rules-manifest.json`ファイルを参照することで、利用可能なルールとその詳細を確認できます。

#### `rules-manifest.json`について

`rules-manifest.json`は、このリポジリで提供されているすべてのルールファイルのリストと、それぞれのメタデータ（説明やタグなど）をまとめたファイルです。このファイルを見ることで、Jun様のプロジェクトに必要なルールを簡単に見つけることができます。

各ルールエントリは以下の情報を含んでいます：
*   `path`: ルールファイルへの相対パス。
*   `description`: ルールの簡単な説明。
*   `tags`: ルールに関連するキーワードやカテゴリ。

#### ルールファイルのダウンロード/コピー方法

必要なルールファイルをJun様のプロジェクトに適用する方法はいくつかあります。

##### 1. 手動でコピーする

このリポジリをクローンした後、`my-rules`ブランチから必要なファイルを直接Jun様のプロジェクトの`.clinerules`ディレクトリにコピーできます。

```bash
# まず、このリポジリをクローンする（まだの場合）
git clone https://github.com/junichi-anada/prompts.git
cd prompts

# my-rulesブランチに切り替える
git checkout my-rules

# Jun様のプロジェクトディレクトリに移動する
cd /path/to/your/project

# .clinerulesディレクトリが存在することを確認する
mkdir -p .clinerules

# 必要なルールファイルをコピーする例
# 例1: 特定のルールファイルをコピー
cp /home/rbsdev/Project/prompts/.clinerules/coding/javascript-coding-guidelines.md ./clinerules/

# 例2: ルールディレクトリ全体をコピー
cp -r /home/rbsdev/Project/prompts/.clinerules/core-behavior ./clinerules/
```

##### 2. GitHub APIを使って直接ダウンロードする（上級者向け）

リポジリ全体をクローンしなくても、GitHubのRawファイルURLを使って特定のルールファイルを直接ダウンロードすることもできます。これは、スクリプトなどで自動化したい場合に便利です。

`rules-manifest.json`の`path`情報と、このリポジリのGitHub URL（`https://raw.githubusercontent.com/junichi-anada/prompts/my-rules/`）を組み合わせることで、各ルールファイルのRaw URLを構築できます。

```bash
# 例: JavaScriptのコーディング規約をダウンロードする
# rules-manifest.jsonからパスを取得: .clinerules/coding/javascript-coding-guidelines.md
# Raw URLを構築: https://raw.githubusercontent.com/junichi-anada/prompts/my-rules/.clinerules/coding/javascript-coding-guidelines.md

# curlを使ってダウンロードする例
mkdir -p /path/to/your/project/.clinerules/coding/
curl -o /path/to/your/project/.clinerules/coding/javascript-coding-guidelines.md \
"https://raw.githubusercontent.com/junichi-anada/prompts/my-rules/.clinerules/coding/javascript-coding-guidelines.md"

# wgetを使ってダウンロードする例
# mkdir -p /path/to/your/project/.clinerules/coding/
# wget -O /path/to/your/project/.clinerules/coding/javascript-coding-guidelines.md \
# "https://raw.githubusercontent.com/junichi-anada/prompts/my-rules/.clinerules/coding/javascript-coding-guidelines.md"
```

### 3. プロジェクトからのルール更新 (PR経由)

各プロジェクトでルールファイルを修正・改善した場合、その変更をこの中央リポジトリに反映させることで、他のプロジェクトでも最新のルールを利用できるようになります。

変更履歴を明確に残すために、**プルリクエスト (Pull Request) を作成する**ことを推奨します。

1.  **このリポジトリのローカルディレクトリに移動します。**
    ```bash
    cd /home/rbsdev/Project/prompts
    ```

2.  **`my-rules`ブランチから、作業用の新しいブランチを作成します。**
    ブランチ名は、変更内容が分かるように `feature/update-js-rules` のようにするのがおすすめです。
    ```bash
    git checkout my-rules
    git pull origin my-rules
    git checkout -b feature/update-js-rules
    ```

3.  **更新したルールファイルを、作業していたプロジェクトからこのリポジトリにコピーします。**
    ```bash
    # 例: javascript-coding-guidelines.md を更新した場合
    cp /path/to/your/project/.clinerules/coding/javascript-coding-guidelines.md ./.clinerules/coding/
    ```

4.  **変更をコミットして、新しいブランチをリモートリポジトリにプッシュします。**
    ```bash
    git add .
    git commit -m "feat(rules): JavaScriptのコーディング規約を更新"
    git push origin feature/update-js-rules
    ```

5.  **GitHub上でプルリクエストを作成します。**
    *   `feature/update-js-rules` ブランチから `my-rules` ブランチへのプルリクエストを作成します。
    *   PRのタイトルや説明に、変更の概要や理由を記述します。

6.  **プルリクエストをマージします。**
    *   内容を確認した後、GitHub上でPRをマージします。
    *   マージ後、作業ブランチは削除してOKです。
```
