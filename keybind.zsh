

# set vi binding
bindkey -v
bindkey jk vi-cmd-mode

echo $XDG_CONFIG_HOME
if [[ -d $XDG_CONFIG_HOME/fzf/shell ]]; then
    source $XDG_CONFIG_HOME/fzf/shell/key-bindings.zsh
    source $XDG_CONFIG_HOME/fzf/shell/completion.zsh
fi

if [[ -f $XDG_CONFIG_HOME/zsh/completion/tmuxinator.zsh ]]; then
    source $XDG_CONFIG_HOME/zsh/completion/tmuxinator.zsh
fi
if [[ -f $XDG_CONFIG_HOME/zsh/keybind/fzf.zsh ]]; then
    source $XDG_CONFIG_HOME/zsh/keybind/fzf.zsh
fi

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

# fix backspace char not function
bindkey -v '^?' backward-delete-char
