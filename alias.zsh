#!/bin/bash

# declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# write a function for adding an alias to the list mentioned above
function abbrev-alias() {
alias $1
ealiases+=(${1%%\=*})
}

# expand any aliases in the current line buffer
function expand-ealias() {
if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
    zle _expand_alias
    zle expand-word
fi
zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '        expand-ealias
bindkey '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}

zle -N accept-line expand-alias-and-accept-line

set_alias () {
    abbrev-alias v='nvim'
    abbrev-alias env='env | fzf'
    abbrev-alias ls='lsd'
    abbrev-alias ll='lsd -l'
    abbrev-alias ecp="echo $PATH | sed 's/:/\\n/g' | fzf"

    # tmux
    abbrev-alias tl='tmux ls'
    abbrev-alias tt='tmux'
    abbrev-alias tas='tmux attach-session -t $(tmux ls | awk '\''{print $1}'\'' | sed -e '\''s/://'\'' | xargs echo -n | fzf )'
    abbrev-alias tks='tmux kill-session -t $(tmux ls | awk '\''{print $1}'\'' | sed -e '\''s/://'\'' | xargs echo -n | fzf )'
    
    # git
    abbrev-alias gcb="git checkout -b"
    abbrev-alias gco='git checkout $(git branch | fzf)'
    abbrev-alias gm='git merge $(git branch | fzf)'
    abbrev-alias gbm='git branch -m '
    abbrev-alias gbd='git branch -d $(git branch | fzf)'
    abbrev-alias gbD='git branch -D $(git branch | fzf)'
    abbrev-alias gl='git log'
    abbrev-alias glo='git log --oneline'

    # docker
    abbrev-alias dsu='sandbox up '
    abbrev-alias du='docker compose up '
    abbrev-alias de='docker compose exec -it $()'
}
