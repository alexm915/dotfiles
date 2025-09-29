set -e
sudo apt update
sudo apt install -y zsh curl git neovim tmux cargo fzf silversearcher-ag btop lazygit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cargo install --git https://github.com/kamiyaa/joshuto.git --force


# set default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
else
    echo "Your default shell is already zsh."
fi

# install chezmoi
if ! command -v chezmoi &> /dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)"
else
    echo "chezmoi already installed."
fi

# initialize dotfiles
chezmoi init alexm915
chezmoi apply
