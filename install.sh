#!/usr/bin/env bash
set -e

# === 基础工具安装 ===
sudo apt update -y
sudo apt install -y curl git cargo silversearcher-ag
sudo apt install -y zsh neovim tmux fzf btop fastfetch lazygit git-delta

sudo apt install -y sudo apt install open-vm-tools
sudo apt install -y build-essential cmake gdb

# === apt库中没有，使用脚本或其他方式安装 ===
#-- oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#-- joshuto
cargo install --git https://github.com/kamiyaa/joshuto.git --force


# === chezmoi ===
if ! command -v chezmoi &> /dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
else
    echo "chezmoi already installed."
fi


# === initialize dotfiles ===
chezmoi init git@github.com:alexm915/dotfiles.git
chezmoi apply


# === Auto Setup Neovim ===
if command -v nvim &> /dev/null; then
    nvim --headless "+Lazy! sync" +qa
else
    echo "Neovim not found, skipping plugin sync."
fi


# == set zsh as default shell ===
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s "$(which zsh)" "$USER"
else
    echo "Your default shell is already zsh."
fi
