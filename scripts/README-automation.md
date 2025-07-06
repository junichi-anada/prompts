# 自動化スクリプト設定ガイド

このディレクトリには、`update-manifest.sh`を定期的に実行するための設定スクリプトが含まれています。

## 利用可能なスクリプト

### 1. validate-rules.sh
- **目的**: ルールファイルの検証
- **使用方法**: `./scripts/validate-rules.sh`
- **機能**: フロントマター検証、manifest整合性チェック

### 2. update-manifest.sh
- **目的**: rules-manifest.jsonの自動更新
- **使用方法**: `./scripts/update-manifest.sh`
- **機能**: ルールファイルからメタデータを抽出してmanifestを更新

## 定期実行の設定方法

### 方法1: cron（推奨・シンプル）

```bash
# セットアップ
./scripts/setup-cron.sh

# 手動確認
crontab -l
tail -f logs/update-manifest.log
```

**メリット:**
- シンプルで理解しやすい
- WSLで安定して動作
- 設定が簡単

### 方法2: systemdタイマー（モダン）

```bash
# セットアップ
./scripts/setup-systemd-timer.sh

# 手動確認
systemctl --user status update-manifest.timer
journalctl --user -u update-manifest.service -f
```

**メリット:**
- より詳細なログ
- 依存関係の管理
- 現代的なLinuxの標準

### 方法3: WSL起動時の自動実行

```bash
# .bashrcに追加（任意）
echo "/home/rbsdev/Project/prompts/scripts/wsl-startup.sh" >> ~/.bashrc
```

## 推奨設定

### 初回セットアップ
1. cronまたはsystemdタイマーのどちらかを選択
2. 頻度は1時間ごと（`0 * * * *`）を推奨
3. WSL起動時スクリプトも併用すると良い

### WSL環境での注意点

#### cronの場合
```bash
# cronサービスの確認・開始
sudo service cron status
sudo service cron start

# WSL起動時に自動開始させる場合
echo "sudo service cron start" >> ~/.bashrc
```

#### systemdの場合
```bash
# ユーザーサービスの確認
systemctl --user list-timers
systemctl --user enable update-manifest.timer
```

## トラブルシューティング

### よくある問題

1. **cronが動かない**
   ```bash
   sudo service cron start
   ```

2. **権限エラー**
   ```bash
   chmod +x scripts/*.sh
   ```

3. **ログが出力されない**
   ```bash
   mkdir -p logs
   touch logs/update-manifest.log
   ```

### ログの確認方法

```bash
# ファイルログ
tail -f logs/update-manifest.log

# systemdログ（systemdタイマー使用時）
journalctl --user -u update-manifest.service -f

# cronログ
grep CRON /var/log/syslog
```

## 使用例

### テスト実行
```bash
# 手動実行
./scripts/update-manifest.sh

# 検証実行
./scripts/validate-rules.sh
```

### 5分間隔でテスト（デバッグ用）
```bash
# cronセットアップ時に選択肢1を選ぶ
./scripts/setup-cron.sh
```

### 本番環境設定（1時間間隔）
```bash
# cronセットアップ時に選択肢3を選ぶ
./scripts/setup-cron.sh
```

## ファイル構成

```
scripts/
├── validate-rules.sh           # ルール検証
├── update-manifest.sh          # マニフェスト更新
├── setup-cron.sh              # cron設定
├── setup-systemd-timer.sh     # systemdタイマー設定
├── wsl-startup.sh              # WSL起動時実行
└── README-automation.md       # このファイル

logs/
└── update-manifest.log         # 実行ログ
```

## 推奨ワークフロー

1. **初期設定**
   ```bash
   ./scripts/setup-cron.sh  # 選択肢3（1時間間隔）
   ```

2. **WSL起動時の自動実行も設定**
   ```bash
   echo "/home/rbsdev/Project/prompts/scripts/wsl-startup.sh" >> ~/.bashrc
   ```

3. **動作確認**
   ```bash
   tail -f logs/update-manifest.log
   ```

これで、ルールファイルを追加・修正するたびに自動的にmanifestが更新されます。