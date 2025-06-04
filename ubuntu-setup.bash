#!/bin/bash

# apt package
sudo apt update -y && sudo apt upgrade -y

# development
sudo apt install -y git gh unzip tree build-essential ffmpeg golang-go
curl -fsSL https://bun.sh/install | bash
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://get.docker.com | sh
sudo snap install ngrok
sudo snap install code --classic
sudo snap install 1password

# node(nvm) <https://nodejs.org/ja/download>
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install node && nvm alias default node

# directory setup
mkdir -p ~/workspace/repo
touch ~/workspace/.env

# write .bashrc
cat >> "$HOME/.bashrc" << 'EOF'
# Load custom workspace bash settings
if [ -f "$HOME/workspace/.custom_bashrc" ]; then
    source "$HOME/workspace/.custom_bashrc"
fi
EOF
# create .custom_bashrc
cat > "$HOME/workspace/.custom_bashrc" << 'EOF'
# move repo directory
if [[ -z "$TERM_PROGRAM" || "$TERM_PROGRAM" != "vscode" ]]; then
  cd /home/user/workspace/repo
fi

# load ~/workspace/.env
if [ -f "$HOME/workspace/.env" ]; then
  set -a
  source "$HOME/workspace/.env"
  set +a
fi
EOF

# git settings
git config --global user.name RateteDev
git config --global user.email 105982649+RateteDev@users.noreply.github.com

# discord
sudo snap install discord steam

