# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zack/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/zack/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zack/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/zack/fzf/shell/key-bindings.bash"
