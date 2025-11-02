# --- CMake Alias ---
alias cmg="cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias cmb="cmake --build build"
alias cmr="cmake --build build && ./build/your_executable"
alias cmc="rm -rf build/*"

# --- fzf Alias ---
alias fz="nvim \$(fzf)"

# --- Other Alias ---
alias update='sudo apt update && sudo apt upgrade -y'
alias ll='ls -lah'

alias vim='nvim'
alias jst='joshuto'
alias cz='chezmoi'
alias f='fastfetch'
alias lg='lazygit'
