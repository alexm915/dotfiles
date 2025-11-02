# ===== Function Alias =====

#--- tmux ---
tm() {
    if [ -z "$1" ]; then
        echo "Usage: tm <session_name>"
        return 1
    fi

    # 如果在 tmux 内，先退出当前 TMUX 环境变量
    [ -n "$TMUX" ] && unset tmux

    # 如果 session 存在则 attach，否则新建
    if tmux has-session -t "$1" 2>/dev/null; then
        tmux attach -t "$1"
    else
        tmux new -s "$1"
    fi
}


# --- search charater and preview file---
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
        rg --files-with-matches --no-messages "$1" | \
            fzf --preview "highlight -O ansi -l {} 2>/dev/null | \
            rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || \
            rg --ignore-case --pretty --context 10 '$1' {}"
}
