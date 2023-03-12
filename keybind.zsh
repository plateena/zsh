

# set vi binding
bindkey -v
bindkey jk vi-cmd-mode

source $XDG_CONFIG_HOME/fzf/shell/key-bindings.zsh
source $XDG_CONFIG_HOME/fzf/shell/completion.zsh

alias sa='source $HOME/.config/zsh/.zshrc; echo "ZSH aliases sourced."'
