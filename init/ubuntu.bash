# Gitをインストール（バージョン管理システム）
sudo apt install git

# unzipをインストール（ZIPファイルを解凍するため）
sudo apt install unzip

# Bunをインストール（Node.jsの代替ランタイム）
curl -fsSL https://bun.sh/install | bash

# uvをインストール（Pythonのパッケージマネージャー）
curl -LsSf https://astral.sh/uv/install.sh | sh

# treeコマンドをインストール（ディレクトリ構造をツリー表示する）
sudo snap install tree

# 開発用のディレクトリを作成
mkdir -p ~/workspace/Project ~/workspace/Handson

# ユーザー名を設定（Gitのコミットに使われる）
read -p "Enter your name: " name
git config --global user.name "$name"

# メールアドレスを設定（Gitのコミットに使われる）
read -p "Enter your email: " email
git config --global user.email "$email"

# デフォルトのブランチ名を「main」に設定
git config --global init.defaultBranch main

echo "Ubuntuの初期化が完了しました！"
