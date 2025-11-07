#!/usr/bin/env bash
set -e

# ====== 基础工具安装 ======
sudo apt update -y
sudo apt install -y curl git zip unzip silversearcher-ag trash-cli tree
sudo apt install -y zsh neovim tmux fzf ripgrep btop fastfetch lazygit git-delta

sudo apt install -y podman
sudo apt install -y build-essential cmake gdb clangd lldb ninja-build


# ====== apt库中没有，使用脚本或其他方式安装 ======
# --- Rust Toolchain ---
if ! command -v rustup &>/dev/null; then
    curl -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    rustup update
    source "$HOME/.cargo/env"
fi

# --- zimfw ---
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# --- Yazi ---
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
cargo install --force --git https://github.com/sxyazi/yazi.git yazi-build



# ====== chezmoi ======
if ! command -v chezmoi &> /dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
else
    echo "chezmoi already installed."
fi


# ====== initialize dotfiles ======
chezmoi init git@github.com:alexm915/dotfiles.git
chezmoi apply


# ====== Auto Setup Neovim ======
if command -v nvim &> /dev/null; then
    nvim --headless "+Lazy! sync" +qa
else
    echo "Neovim not found, skipping plugin sync."
fi


# ===== set zsh as default shell ======
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s "$(which zsh)" "$USER"
else
    echo "Your default shell is already zsh."
fi
