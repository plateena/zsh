# set vi binding or vi mode
bindkey -v
bindkey jk vi-cmd-mode
export KEYTIMEOUT=20

# copy current command to clipboard
vi-yank-x-selection () { echo -n $BUFFER | wl-copy }
zle -N vi-yank-x-selection
bindkey '^[Y' vi-yank-x-selection
bindkey -a '^[Y' vi-yank-x-selection

bindkey -M vicmd 'k' up-line-or-history
bindkey -M vicmd 'j' down-line-or-history

# Atuin: session-scoped search (current tmux pane)
_atuin_session_search() { _atuin_search --filter-mode session; }
zle -N atuin-session-search _atuin_session_search
bindkey -M viins '^[r' atuin-session-search  # Alt+R = current session/pane
bindkey -M vicmd '^[r' atuin-session-search

# Edit line in nvim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
