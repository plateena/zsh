# set vi binding or vi mode
bindkey -v
bindkey jk vi-cmd-mode
export KEYTIMEOUT=50

# copy current command to clipboard
vi-yank-x-selection () { echo -n $BUFFER | xclip -selection clipboard }
zle -N vi-yank-x-selection
bindkey '^[Y' vi-yank-x-selection
bindkey -a '^[Y' vi-yank-x-selection

#Edit line in nvim
# autoload edit-commnd-line
# zle -N edit-commnd-line
# bindkey -M vicmd v edit-commnd-line

# # fix backspace char not function
# bindkey -v '^?' backward-delete-char
