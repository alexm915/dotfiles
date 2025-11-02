# ======= fzf configs ======

export FZF_DEFAULT_OPTS='--bind=ctrl-t:top,change:top --bind ctrl-j:down,ctrl-k:up'
export FZF_DEFAULT_COMMAND='fd'
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'
export fzf_preview_cmd='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'


# ====== Auto load fzf autocomplete and shortcut =======
if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
    source /usr/share/doc/fzf/examples/completion.zsh
fi
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi


# ====== Customize fzf Widgets ======
# --- widget 1 ---
fzf-redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
        $precmd
    done
    zle reset-prompt
}
zle -N fzf-redraw-prompt

zle -N fzf-find-widget
bindkey '^p' fzf-find-widget


# --- widget 2 ---
fzf-cd-widget() {
    local tokens=(${(z)LBUFFER})
    if (( $#tokens <= 1 )); then
        zle fzf-find-widget 'only_dir'
        if [[ -d $LBUFFER ]]; then
            cd $LBUFFER
            local ret=$?
            LBUFFER=
            zle fzf-redraw-prompt
            return $ret
        fi
    fi
}
zle -N fzf-cd-widget
bindkey '^t' fzf-cd-widget


# --- widget 3 ---
fzf-history-widget() {
    local num=$(fhistory $LBUFFER)
    local ret=$?
    if [[ -n $num ]]; then
        zle vi-fetch-history -n $num
    fi
    zle reset-prompt
    return $ret
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget


# --- widget 4 ---
find-in-file() {
    grep --line-buffered --color=never -r "" * | fzf
}
zle -N find-in-file
bindkey '^f' find-in-file
