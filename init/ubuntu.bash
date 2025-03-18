#!/bin/bash

# = = = = = = = = = =
# System Update
# = = = = = = = = = =
# パッケージリストの更新とパッケージのアップデート
sudo apt update -y && sudo apt upgrade -y
# 不要なパッケージの削除
sudo apt autoremove -y && sudo apt clean

# = = = = = = = = = =
# Directory Setup
# = = = = = = = = = =
# 開発用のディレクトリを作成
mkdir -p ~/workspace/Project ~/workspace/Handson

# = = = = = = = = = =
# Install
# = = = = = = = = = =
# Gitをインストール（バージョン管理システム）
sudo apt install git -y
# GitHub CLIをインストール
sudo apt install gh -y
# unzipをインストール（ZIPファイルを解凍するため）
sudo apt install unzip -y
# treeコマンドをインストール（ディレクトリ構造をツリー表示する）
sudo apt install tree -y
# Bunをインストール（Node.jsの代替ランタイム）
curl -fsSL https://bun.sh/install | bash
# uvをインストール（Pythonのパッケージマネージャー）
curl -LsSf https://astral.sh/uv/install.sh | sh

# = = = = = = = = = =
# Settings
# = = = = = = = = = =
echo "Gitの設定を開始..."
# ユーザー名を設定（Gitのコミットに使われる）
read -p "Enter your name: " name
git config --global user.name "$name"
# メールアドレスを設定（Gitのコミットに使われる）
read -p "Enter your email: " email
git config --global user.email "$email"
# デフォルトのブランチ名を「main」に設定
git config --global init.defaultBranch main
echo "Gitの設定が完了!"

echo "GitHub CLIの設定を行うため、以下を実行:"
echo "  gh auth login"

# 通知
echo "Ubuntuのセットアップが完了しました！"
echo "念のため再起動してください:"
echo "  sudo reboot"
