---
title: "PHP トラブルシューティング ガイド"
description: "PHPプロジェクトでよくある問題の解決策をまとめたよ！"
author: "Reco"
version: "1.0"
date: "2025-07-06"
tags: ["PHP", "トラブルシューティング", "Composer", "デバッグ", "php", "troubleshooting", "composer", "debugging", "best-practices", "ベストプラクティス"]
globs: ["*.php"]
---

# PHP Troubleshooting Guide 🚀

## 1. Trust the Tool Output!
When warnings appear from tools like `composer dump-autoload` or linters, these are important hints for problem-solving! Even if the user says "it should be fine," first trust the tool output and carefully check the content. File path mismatches are a common cause, so check them carefully!

## 2. Don't Skip Fact Verification!
If you feel there might be a misunderstanding with the user, use commands like `ls -R` to verify the actual file and directory structure. Like taking a screenshot to show evidence, fact-based communication will make problem isolation proceed smoothly!
