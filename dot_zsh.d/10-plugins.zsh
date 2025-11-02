# ====== Plugins ======
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    z
)

source $ZSH/oh-my-zsh.sh


# ====== Autocomplete and highlight ======
autoload -Uz compinit
compinit -u   # -u选项跳过安全检查加快启动速度

bindkey '^I' expand-or-complete
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
