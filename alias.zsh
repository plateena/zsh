#!/bin/zsh

# Aliases Configuration

# Declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# Function: abbrev-alias
# -----------------------
# Adds an alias to the list of expandable aliases
function abbrev-alias() {
    alias $1
    ealiases+=(${1%%\=*})
}

# Function: expand-ealias
# -----------------------
# Expands any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function
bindkey ' '        expand-ealias
bindkey '^ '       magic-space     # Control-space to bypass completion
bindkey -M isearch " "      magic-space     # Normal space during searches

# Function: expand-alias-and-accept-line
# ---------------------------------------
# Expands any aliases before accepting the line and executing the entered command
function expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line

# Function: set_alias
# ---------------------
# Sets common aliases
set_alias () {
    abbrev-alias shn='shutdown now'
    abbrev-alias srn='shutdown -r now'

    abbrev-alias al='alias | fzf | xargs echo -e'
    abbrev-alias cl='clear'
    abbrev-alias ecp="echo $PATH | sed 's/:/\\n/g' | fzf | xargs echo -e"
    abbrev-alias env='env | fzf | xargs ehco -e'
    abbrev-alias his='history'
    abbrev-alias ll='eza --color=always --icons=always -l'
    abbrev-alias lla='eza --color=always --icons=always -la'
    abbrev-alias lse='eza --color=always --icons=always'
    abbrev-alias todop='welcome global-todo'
    abbrev-alias v='nvim'

    abbrev-alias ala-theme='bash ~/.config/alacritty/bin/alacritty-command theme $( find ~/.config/alacritty/themes/*.toml | awk -F"/" '\''{print $NF}'\'' | sed '\''s/.toml//'\'' | fzf | xargs echo -e)'
    abbrev-alias ala-font='bash ~/.config/alacritty/bin/alacritty-command font $(fc-list : family | sort | uniq | fzf | sed '\''s/ /\_\_/g'\'' | xargs -I {} echo -e {} )'
    abbrev-alias ala-fontsize='bash ~/.config/alacritty/bin/alacritty-command fontsize '

    # tmux
    abbrev-alias tas='tmux attach-session -t $(tmux ls | sed -e '\''s/://'\'' | awk '\''{print $1}'\'' | fzf | xargs echo -e)'
    abbrev-alias tks='tmux kill-session -t $(tmux ls | sed -e '\''s/://'\'' | awk '\''{print $1}'\'' | fzf | xargs echo -e)'
    abbrev-alias tls='tmux ls'

    # git
    abbrev-alias gfo='git fetch origin'
    abbrev-alias gpl='git pull'

    abbrev-alias gbl='git branch'
    abbrev-alias gbD='git branch -D $(git branch | fzf | xargs echo -e)'
    abbrev-alias gbd='git branch -d $(git branch | fzf | xargs echo -e)'
    abbrev-alias gbm='git branch -m '
    abbrev-alias gsb='git switch $(git branch -r | fzf | sed -e '\''s/origin\///g'\'' | xargs echo -e)'
    abbrev-alias gcb="git checkout -b"
    abbrev-alias gcm='git checkout master'
    abbrev-alias gco='git checkout $(git branch | fzf | xargs echo -e)'
    abbrev-alias gl='git log'
    abbrev-alias gf='git fetch'
    abbrev-alias glo='git log --oneline'
    abbrev-alias gm='git merge $(git branch | fzf | xargs echo -e)'
    abbrev-alias gmc='git merge --continue'
    abbrev-alias gma='git merge --abort'
    abbrev-alias gps='git push origin $(git branch | sed '\''s/[* ]//g'\'' | fzf | xargs echo -e)'
    abbrev-alias gpsc='git push origin $(git branch --show-current | xargs echo -e)'
    abbrev-alias gst="git status"
    abbrev-alias gpb='git pull origin $(git branch | fzf | awk '\''{print $2}'\'' | xargs echo -e)'
    abbrev-alias gpc='git pull origin $(git branch --show-current | xargs echo -e)'
    abbrev-alias gpo='git pull origin'
    # check https://git-scm.com/docs/pretty-formats
    abbrev-alias glp='git log --pretty=format:"%C(auto) %h %>(13,trunc)%ch %Cblue%cn%C(auto)%d %s"'
    abbrev-alias gcn='git config user.name '
    abbrev-alias gce='git config user.email '

    # docker
    abbrev-alias dc='docker compose '
    abbrev-alias dcl='docker compose logs $(docker ps | tail -n +2 | awk '\''{print $NF}'\'' | fzf | xargs echo -e )'
    abbrev-alias de='docker exec -it $(docker ps | tail -n +2 | awk '\''{print $NF}'\'' | fzf | xargs echo -e )'
    abbrev-alias dcu='docker compose up '
    abbrev-alias dps='docker ps'

    # npm
    abbrev-alias nrt='npm run test'
    abbrev-alias nrd='npm run dev'
    abbrev-alias nrwd='npm run watch-dev'
    abbrev-alias nrs='npm run start'
    abbrev-alias nrb='npm run build'
    abbrev-alias nrw='npm run watch'
    abbrev-alias ni='npm instal'
    abbrev-alias nis='npm instal --save '
    abbrev-alias nid='npm install --save-dev '

    # Timewarrior
    abbrev-alias tm='timew'
    abbrev-alias tms='timew summary :ids'
    abbrev-alias tmw='timew week'
    abbrev-alias tmd='timew day'
    abbrev-alias tmes='(){timew modify start @1 $1 :adjust }'
    abbrev-alias tmee='(){timew modify end @1 $1 :adjust }'
    abbrev-alias tmman='(){timew start "${1:-Works management}" "work.management"}'
    abbrev-alias tmmet='(){timew start "${1:-Meeting}" "work.meeting"}'

    # Taskwarrior
    # abbrev-alias ts='task '
    abbrev-alias tsac='task +ACTIVE'
    abbrev-alias tsdep='(){task $1 modify -ToDo -InProgress -CodeReview +Deployed -UAT}'
    abbrev-alias tscr='(){task $1 modify -ToDo -InProgress +CodeReview -Deployed -UAT}'
    abbrev-alias tsip='(){task $1 modify -ToDo +InProgress -CodeReview -Deployed -UAT}'
    abbrev-alias tstd='(){task $1 modify +ToDo -InProgress -CodeReview -Deployed -UAT}'
    abbrev-alias tsut='(){task $1 modify -ToDo -InProgress -CodeReview -Deployed +UAT}'
    abbrev-alias tspr='(){task $1 modify -ToDo -InProgress -CodeReview -Deployed -UAT +PendingRelease}'

    # work
    abbrev-alias dcw='docker compose exec -it erp '
    abbrev-alias dcspec='docker compose exec -it erp rspec --fail-fast ./spec/'
    abbrev-alias dccon='docker compose exec -it erp rails c'
}

# Initialize common aliases
set_alias

# Documentation:
# - This script defines expandable aliases that can be expanded using the space key.
# - The 'abbrev-alias' function adds an alias to the list of expandable aliases.
# - 'expand-ealias' expands aliases in the current line buffer upon pressing space.
# - 'expand-alias-and-accept-line' expands aliases before executing the entered command.
# - The 'set_alias' function sets common aliases.
# - Make sure to source this script in your Zsh configuration to enable these aliases.
