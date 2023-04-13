# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zack/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/zack/fzf/bin"
fi

if [[ -f "/home/zack/fzf/shell/completion.zsh" ]]; then
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/home/zack/fzf/shell/completion.zsh" 2> /dev/null
fi

if [[ -f "/home/zack/fzf/shell/key-bindings.zsh" ]]; then
    # Key bindings
    # ------------
    source "/home/zack/fzf/shell/key-bindings.zsh"
fi

if [[ -f "/home/zack/.config/fzf/shell/completion.zsh" ]]; then
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/home/zack/.config/fzf/shell/completion.zsh" 2> /dev/null
fi

if [[ -f "/home/zack/.config/fzf/shell/key-bindings.zsh" ]]; then
    # Key bindings
    # ------------
    source "/home/zack/.config/fzf/shell/key-bindings.zsh"
fi
