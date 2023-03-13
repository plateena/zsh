

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

vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -a '^X' vi-append-x-selection
vi-yank-x-selection () { print -rn -- $CUTBUFFER | xsel -i -p; }
zle -N vi-yank-x-selection
bindkey -a '^Y' vi-yank-x-selection
