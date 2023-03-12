

# set vi binding
bindkey -v
bindkey jk vi-cmd-mode

source $XDG_CONFIG_HOME/fzf/shell/key-bindings.zsh
source $XDG_CONFIG_HOME/fzf/shell/completion.zsh

zstyle ':completion:*' menu select
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
