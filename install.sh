#!/usr/bin/env bash
# =============================================================================
# usage:
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/alexm915/dotfiles/main/install.sh)"
# =============================================================================

set -euo pipefail

REPO_URL="${CHEZMOI_REPO_URL:-https://github.com/alexm915/dotfiles.git}"

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

    if [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
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
        chezmoi update
    else
        log info "initializing chezmoi from ${REPO_URL}"
        chezmoi init --apply "${REPO_URL}"
    fi

    log info "done"
    log info "machine-specific values live in ~/.config/chezmoi/chezmoi.toml"
}

main "$@"