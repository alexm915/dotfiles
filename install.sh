#!/usr/bin/env bash
set -e

# ====== basic tools ======
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm man-db base-devel curl git zip unzip the_silver_searcher trash-cli tree
sudo pacman -S --noconfirm zsh neovim tmux fzf ripgrep btop fastfetch lazygit git-delta
sudo pacman -S --noconfirm cmake gdb clang lldb ninja
sudo pacman -S --noconfirm chezmoi yazi

# ====== config git ======
git config --global user.name "alex"
git config --global user.email "thealbertmak@gmail.com"
git config --global init.defaultBranch main

# ====== zimfw ======
if [ ! -d "$HOME/.zim" ]; then
    echo "Installing zimfw..."
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    echo "zimfw already installed."
fi

# ====== Set zsh as default shell ======
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
else
    echo "Your default shell is already zsh."
fi

# ====== Auto Setup Neovim ======
if command -v nvim &>/dev/null; then
    echo "Syncing Neovim plugins..."
    nvim --headless "+Lazy! sync" +qa
else
    echo "Neovim not found, skipping plugin sync."
fi

# ====== initialize dotfiles ======
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    chezmoi init git@github.com:alexm915/dotfiles.git
    chezmoi apply
else
    echo "chezmoi already initialized."
fi
