#!/bin/bash

# Bunプロジェクトを初期化
bun init

# srcフォルダを作成し、index.tsを移動
mkdir -p src && mv index.ts src/

# .envファイルを作成し、LOG_LEVEL=INFO を書き込む
echo "LOG_LEVEL=INFO" > .env

# Gitリポジトリを初期化
git init

# 必要なディレクトリを作成
mkdir -p docs assets scripts data

# README.mdを作成
echo "# TODO: Replace Your Project Name" > README.md

echo "Bunプロジェクトの初期化が完了しました！"
