# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zainundin/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/zainundin/fzf/bin"
fi

if [[ -f "/home/zainundin/fzf/shell/completion.zsh" ]]; then
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/home/zainundin/fzf/shell/completion.zsh" 2> /dev/null
fi

if [[ -f "/home/zainundin/fzf/shell/key-bindings.zsh" ]]; then
    # Key bindings
    # ------------
    source "/home/zainundin/fzf/shell/key-bindings.zsh"
fi

if [[ -f "/home/zainundin/.config/fzf/shell/completion.zsh" ]]; then
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/home/zainundin/.config/fzf/shell/completion.zsh" 2> /dev/null
fi

if [[ -f "/home/zainundin/.config/fzf/shell/key-bindings.zsh" ]]; then
    # Key bindings
    # ------------
    source "/home/zainundin/.config/fzf/shell/key-bindings.zsh"
fi
