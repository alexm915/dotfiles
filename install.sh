set -e
sudo apt update
sudo apt install -y zsh tmux neovm git curl oh-my-zsh

# set default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
else
    echo "Your default shell is already zsh."
fi

# install chezmoi
if ! command -v chezmoi &> /dev/null; then
    sudo apt install -y chezmoi
else
    echo "chezmoi already installed."
fi

# initialize dotfiles
chezmoi init alexm915
chezmoi apply
