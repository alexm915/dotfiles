#!/usr/bin/env bash

# ===== chezmoi apply, then automate do below =====

# refresh zsh config
if command -v zsh &> /dev/null; then
    zsh -c "source ~/.zshrc"
    echo "refresh zshrc done!"
    echo "=========================="
fi

# refresh neovim config
if command -v nvim &> /dev/null; then
    nvim --headless "+Lazy! sync" +qa
    echo "refresh neovim config done!"
    echo "=========================="
fi

echo "=========================="
echo "All post-apply setup done!"
