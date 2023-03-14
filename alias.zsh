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
    abbrev-alias shn='shutdown now'
    abbrev-alias srn='shutdown -r now'

    abbrev-alias al='alias | fzf | xargs echo -e'
    abbrev-alias cl='clear'
    abbrev-alias ecp="echo $PATH | sed 's/:/\\n/g' | fzf | xargs echo -e"
    abbrev-alias env='env | fzf | xargs ehco -e'
    abbrev-alias his='history'
    abbrev-alias ll='lsd -l'
    abbrev-alias lla='lsd -la'
    abbrev-alias ls='lsd'
    abbrev-alias todop='welcome global-todo'
    abbrev-alias v='nvim'

    abbrev-alias ala-theme='bash ~/.config/alacritty/bin/alacritty-command theme $( lsd ~/.config/alacritty/themes | sed '\''s/.yaml//'\'' | fzf | xargs echo -e)'
    abbrev-alias ala-font='bash ~/.config/alacritty/bin/alacritty-command font $(fc-list : family | sort | uniq | fzf | sed '\''s/ /\_\_/g'\'' | xargs -I {} echo -e {} )'
    abbrev-alias ala-fontsize='bash ~/.config/alacritty/bin/alacritty-command fontsize '

    # tmux
    abbrev-alias tas='tmux attach-session -t $(tmux ls | sed -e '\''s/://'\'' | awk '\''{print $1}'\'' | fzf | xargs echo -e)'
    abbrev-alias tks='tmux kill-session -t $(tmux ls | sed -e '\''s/://'\'' | awk '\''{print $1}'\'' | fzf | xargs echo -e)'
    abbrev-alias tl='tmux ls'
    abbrev-alias tt='tmux'
    
    # git
    abbrev-alias gbl='git branch'
    abbrev-alias gbD='git branch -D $(git branch | fzf | xargs echo -e)'
    abbrev-alias gbd='git branch -d $(git branch | fzf | xargs echo -e)'
    abbrev-alias gbm='git branch -m '
    abbrev-alias gcb="git checkout -b"
    abbrev-alias gco='git checkout $(git branch | fzf | xargs echo -e)'
    abbrev-alias gl='git log'
    abbrev-alias glo='git log --oneline'
    abbrev-alias gm='git merge $(git branch | fzf | xargs echo -e)'
    abbrev-alias gps='git push origin $(git branch | sed '\''s/[* ]//g'\'' | fzf | xargs echo -e)'
    abbrev-alias gpsc='git push origin $(git branch --show-current | xargs echo -e)'
    abbrev-alias gst="git status"
    abbrev-alias gp='git pull origin $(git branch | fzf | awk '\''{print $2}'\'' | xargs echo -e)'
    abbrev-alias gpc='git pull origin $(git branch --show-current | xargs echo -e)'
    # check https://git-scm.com/docs/pretty-formats
    abbrev-alias glp='git log --pretty=format:"%C(auto) %h %>(9,trunc)%ch %Cblue%cn%C(auto)%d %s"'
    abbrev-alias gcn='git config user.name '
    abbrev-alias gce='git config user.email '

    # docker
    abbrev-alias de='docker compose exec -it $()'
    abbrev-alias dsu='sandbox up '
    abbrev-alias du='docker compose up '
}
