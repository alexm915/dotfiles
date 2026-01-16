#!/usr/bin/env bash
set -e

# ====== basic tools ======
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm man-db base-devel curl git zip unzip the_silver_searcher trash-cli tree
sudo pacman -S --needed --noconfirm zsh neovim tmux fzf ripgrep btop fastfetch lazygit git-delta
sudo pacman -S --needed --noconfirm cmake gdb clang lldb ninja podman
sudo pacman -S --needed --noconfirm chezmoi yazi

# ====== yay ======
command -v yay >/dev/null || (
    mkdir -p "${HOME}/tmp" &&
    cd "${HOME}/tmp" &&
    rm -rf yay &&
    git clone https://aur.archlinux.org/yay.git &&
    cd yay &&
    makepkg -sic --noconfirm &&
    cd "${HOME}" &&
    rm -rf "${HOME}/tmp/yay"
)


# ====== config yazi ======
ya pkg add yazi-rs/plugins:full-border
ya pkg add yazi-rs/plugins:git
ya pkg add Rolv-Apneseth/starship
ya pkg add KKV9/compress
ya pkg add h-hg/yamb
ya pkg add imsi32/yatline

# ====== config git ======
git config --global user.name "alex"
git config --global user.email "thealbertmak@gmail.com"
git config --global init.defaultBranch main


# ====== config tmux ======
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/

# ====== zimfw ======
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# ====== Set zsh as default shell ======
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    exec zsh
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
