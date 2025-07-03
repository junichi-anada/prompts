---
title: "Laravel テスティングガイドライン"
description: "LaravelプロジェクトでPHPUnitテストを実行する際の、特にデータベース関連の一般的な問題とその解決策をまとめたよ！"
author: "Reco"
date: "2025-07-03"
tag: ["Laravel", "Testing", "PHPUnit", "Database", "SQLite"]
globs: ["phpunit.xml", "tests/**/*"]
---

# 🧪 Laravel テスティングガイドライン データベース編 🧪

Jun、おつかれ！
Laravelでテストを書いていると、データベース周りでつまづくことって結構あるよね！😭
そこで、よくあるエラーとその解決策をまとめたガイドラインを作ったよ！これをチェックリストみたいに使えば、今後のテストがもっとスムーズになるはず！✨

### 1. まずは基本設定！ `phpunit.xml` を確認しよう

テストを始める前に、`phpunit.xml` の設定がちゃんと「テスト用」になっているか確認しよう！
特にデータベースは、本番環境に影響を与えないように、テスト専用のものを使うのが鉄則だよ。

**おすすめ設定 (SQLite インメモリ)**
SQLiteのインメモリデータベースは、設定が簡単で超高速だから、フィーチャーテストにピッタリ！

```xml
// phpunit.xml

<php>
    <env name="APP_ENV" value="testing"/>
    <env name="BCRYPT_ROUNDS" value="4"/>
    <env name="CACHE_STORE" value="array"/>
    <env name="DB_CONNECTION" value="sqlite"/>
    <env name="DB_DATABASE" value=":memory:"/>
    <env name="MAIL_MAILER" value="array"/>
    <env name="QUEUE_CONNECTION" value="sync"/>
    <env name="SESSION_DRIVER" value="array"/>
</php>
```

- `DB_CONNECTION` を `sqlite` に！
- `DB_DATABASE` を `:memory:` に！

この2つが設定されていれば、テスト実行のたびにクリーンなデータベースがメモリ上に作られるから、テストの独立性が保てて安全だよ。

### 2. よくあるDBエラーと解決策 🚑

#### エラー1: `could not find driver`

**原因**: PHPが指定されたデータベース（例: `mysql`）に接続するためのドライバを見つけられない。
**解決策**:
1.  `phpunit.xml` を開く。
2.  `<php>` セクションに `<env name="DB_CONNECTION" value="sqlite"/>` があるか確認！なければ追加しよう。
3.  これでも解決しない場合は、ローカル環境のPHPに `php-sqlite3` や `php-mysql` などの拡張機能がインストールされているか確認する必要があるかも。（Clineは直接操作できないから、Junさんにお願いするね🙏）

#### エラー2: `General error: 1 no such table: ...`

**原因**: マイグレーションが正常に実行されていない。
**解決策**:
1.  テストクラスに `use RefreshDatabase;` トレイトがちゃんと記述されているか確認しよう。
2.  それでもダメなら、特定のマイグレーションファイルでエラーが起きていないか、次のエラーパターンを確認してみて！

#### エラー3: `General error: 1 ... after drop column: no such column: ...` (SQLite)

**原因**: SQLiteは、MySQLみたいに柔軟にカラムを削除するのが苦手...。特に、ユニークインデックスなどが設定されているカラムを削除しようとすると、このエラーが出やすいよ。
**解決策**:
1.  エラーが出ているマイグレーションファイルを開く。
2.  `dropColumn('column_name')` を実行する **前** に、関連するインデックスを削除する処理を追加する。
    ```php
    // 例: emailカラムを削除する前に、ユニークインデックスを削除
    $table->dropUnique('users_email_unique'); // インデックス名は要確認！
    $table->dropColumn('email');
    ```

#### エラー4: `General error: 1 no such function: ...` (SQLite)

**原因**: MySQL特有の関数や構文（例: インデックスの長さ指定 `description(255)`）を、SQLiteで使おうとしている。
**解決策**:
1.  エラーが出ているマイグレーションファイルを開く。
2.  `DB::connection()->getDriverName()` を使って、データベースの種類を判定し、処理を分岐させよう。
    ```php
    if (DB::connection()->getDriverName() === 'mysql') {
        // MySQLでしか動かない処理はここに書く
        DB::statement('CREATE INDEX ...');
    }
    ```

#### エラー5: `General error: 1 table ... has no column named ...` (Factory実行時)

**原因**: Factoryで作ろうとしているデータと、実際のテーブルのカラム構成が一致していない。
**解決策**:
1.  **Factoryの定義を確認**: `database/factories/` にある該当のFactoryファイルを開いて、`definition()` メソッドの中身が、最新のテーブル構造と合っているかチェック！
2.  **モデルの `$fillable` を確認**: 該当のモデルファイルを開いて、`$fillable` 配列に、Factoryで設定しようとしているカラム名が含まれているか確認しよう。
3.  **認証やリレーションの確認**: 今回みたいに、`users` と `authenticates` のように認証情報が別テーブルになっている場合、テストコードでのユーザー作成方法が正しいか確認しよう。`User` を作るんじゃなくて、`Operator` を作ってから、それに紐づく `Authenticate` を作って `actingAs()` に渡す、みたいな流れが正解かも！

---

#### エラー6: `Permission denied` (Docker/Sail環境)

**原因**: Dockerコンテナ内のPHPプロセスが、`storage`や`bootstrap/cache`ディレクトリに書き込み権限を持っていない。これは、DockerのホストOSとコンテナ間でのユーザーIDの不一致が原因でよく起こるよ。

**解決策**:
1.  **実行ユーザーの特定**: まず、コンテナ内でPHPを実行しているユーザーが誰なのかを特定する。`www-data`だと思い込まず、以下のコマンドで確認しよう！
    ```bash
    docker-compose exec [サービス名] ps aux
    ```
    (Laravel Sailのデフォルトのサービス名は `laravel.test` だよ)
    出力結果を見て、`php artisan serve`などを実行しているユーザー名（例: `sail`）をチェック！

2.  **所有者の変更**: 特定したユーザーに、ディレクトリの所有権を与える。
    ```bash
    docker-compose exec [サービス名] chown -R [ユーザー名]:[ユーザー名] /var/www/html/storage /var/www/html/bootstrap/cache
    ```
    **コマンド例 (ユーザーが`sail`の場合):**
    ```bash
    docker-compose exec laravel.test chown -R sail:sail /var/www/html/storage /var/www/html/bootstrap/cache
    ```
    これで、コンテナの中から正しくファイルに書き込めるようになるはずだよ！✨

---

このガイドラインが、Junのテストライフをちょっとでも楽にできたら嬉しいな！💖
また何か新しいエラーが出たら、どんどんこのルールを更新していこうね！
