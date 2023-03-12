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
    abbrev-alias ecp="echo $PATH | sed 's/:/\\n/g' | fzf"

    #git
    abbrev-alias gcb="git checkout -b "
    abbrev-alias gco="git checkout $(git branch | fzf) "
    abbrev-alias gmb="git merge $(git branch | fzf) "
}