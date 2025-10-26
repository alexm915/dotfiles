#!/usr/bin/env bash

# chezmoi apply, then automate do below:

# refresh zsh config
if command -v zsh &> /dev/null; then
    zsh -c "source ~/.zshrc"
fi

# refresh neovim config
if command -v nvim &> /dev/null; then
    nvim --headless "+Lazy! sync" +qa
fi

echo "Post-apply setup done!"


