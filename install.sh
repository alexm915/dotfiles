#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${CHEZMOI_REPO_URL:-https://github.com/alexm915/dotfiles.git}"
# or git repo:
# REPO_URL=git@github.com:alexm915/dotfiles.git ./install.sh

log() {
    printf '[%s] %s\n' "$1" "$2"
}

setup_homebrew_shellenv() {
    if command -v brew >/dev/null 2>&1; then
        return 0
    fi

    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        return 0
    fi

    return 1
}

bootstrap_macos() {
    log info "detected macOS"

    if ! xcode-select -p >/dev/null 2>&1; then
        log info "Xcode Command Line Tools not found; launching installer"
        xcode-select --install || true
    fi

    if ! setup_homebrew_shellenv; then
        log info "installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        setup_homebrew_shellenv
    fi

    brew update
    brew install git chezmoi
}

bootstrap_arch() {
    log info "detected Arch Linux"
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm ca-certificates curl git chezmoi base-devel
}


main() {
    case "$(uname -s)" in
        Darwin)
            bootstrap_macos
            ;;
        Linux)
            if [ -r /etc/os-release ]; then
                . /etc/os-release
            fi
            if [ "${ID:-}" = "arch" ] || printf '%s' "${ID_LIKE:-}" | grep -qi 'arch'; then
                bootstrap_arch
            else
                log error "this bootstrap script currently supports macOS and Arch Linux only"
                exit 1
            fi
            ;;
        *)
            log error "unsupported OS: $(uname -s)"
            exit 1
            ;;
    esac

    if [ -d "${HOME}/.local/share/chezmoi/.git" ]; then
        log info "chezmoi source already exists; applying"
        chezmoi apply
    else
        log info "initializing chezmoi from ${REPO_URL}"
        chezmoi init --apply "${REPO_URL}"
    fi

    log info "done"
    log info "machine-specific values live in ~/.config/chezmoi/chezmoi.toml"
}






## =========================old config
##!/usr/bin/env bash
#set -e
#
## ====== basic tools ======
#sudo pacman -Syu --noconfirm
#sudo pacman -S --needed --noconfirm man-db base-devel curl git zip unzip the_silver_searcher trash-cli tree
#sudo pacman -S --needed --noconfirm zsh neovim tmux fzf ripgrep htop fastfetch lazygit git-delta
#sudo pacman -S --needed --noconfirm cmake make ninja gdb clang llvm lldb bear podman
#sudo pacman -S --needed --noconfirm chezmoi yazi
## --- vibe coding
#sudo pacman -S --needed --noconfirm nodejs npm
#sudo npm install -g @anthropic-ai/claude-code
#
#
## ====== yay ======
#command -v yay >/dev/null || (
#    mkdir -p "${HOME}/tmp" &&
#    cd "${HOME}/tmp" &&
#    rm -rf yay &&
#    git clone https://aur.archlinux.org/yay.git &&
#    cd yay &&
#    makepkg -sic --noconfirm &&
#    cd "${HOME}" &&
#    rm -rf "${HOME}/tmp/yay"
#)
#
#
## ====== config yazi ======
#ya pkg add yazi-rs/plugins:full-border
#ya pkg add yazi-rs/plugins:git
#ya pkg add Rolv-Apneseth/starship
#ya pkg add KKV9/compress
#ya pkg add h-hg/yamb
#ya pkg add imsi32/yatline
#
## ====== config git ======
#git config --global user.name "alex"
#git config --global user.email "thealbertmak@gmail.com"
#git config --global init.defaultBranch main
#
#
## ====== config tmux ======
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/
#
## ====== zimfw ======
#curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
#
## ====== Set zsh as default shell ======
#if [ "$SHELL" != "$(which zsh)" ]; then
#    echo "Setting zsh as default shell..."
#    chsh -s "$(which zsh)"
#    exec zsh
#else
#    echo "Your default shell is already zsh."
#fi
#
## ====== Auto Setup Neovim ======
#if command -v nvim &>/dev/null; then
#    echo "Syncing Neovim plugins..."
#    nvim --headless "+Lazy! sync" +qa
#else
#    echo "Neovim not found, skipping plugin sync."
#fi
#
## ====== initialize dotfiles ======
#if [ ! -d "$HOME/.local/share/chezmoi" ]; then
#    chezmoi init git@github.com:alexm915/dotfiles.git
#    chezmoi apply
#else
#    echo "chezmoi already initialized."
#fi
