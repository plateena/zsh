#!/bin/bash

# can checkot color at https://www.tweaking4all.com/software/macosx-software/xterm-color-cheat-sheet/
black="235"
white="015"
# dir_arrow_end_bg="039"
dir_arrow_end_bg="039"

# zstyle ':vcs_info:git:*' formats '%b '

source $ZDOTDIR/scripts/shortendir.sh

# check icon at https://www.nerdfonts.com/cheat-sheet 
branch_icon() {
    # printf "\uf418"
    printf "\ue725"
}
check_icon() {
    # printf "\uf058" # rounded check
    printf "\ue63f" # rounded check
}
exclamation_icon() {
    # printf "\uf06a" # rounded exclamation
    printf "\uf12a" # fat exclamation
}

git_branch_name () {
    branch=$(git branch --show-current)
    local bg="red"
    local prefix=$(git rev-parse --show-prefix | sed 's/\/$//')
    local pr=""
    local dir=$(git rev-parse --show-toplevel)

    # check if the git status has diff
    if [[ $(git diff) ]]; then
        bg="196"
    else
        bg="166"
    fi

    # to check the current git status is clean
    if [ -z "$(git status --porcelain)" ]; then
        bg="036"
    fi

    dir_arrow_end_bg="$bg"

    dir=$(shorten_dir $dir 20)

    if [[ ! -z "$prefix" ]]; then
        prefix=$(shorten_dir $prefix 10)
    fi

    # directory
    pr+="%K{$black}%F{green} $dir %K{$bg}%F{$black}"
    # branch
    pr+="%K{$bg}%F{015} %B$(branch_icon) $branch %K{$black}%F{$bg}"

    if [ ! -z "$prefix" ]; then
        pr+=" %F{green}$prefix %K{039}%F{$black}%F{none}"
    else
        pr+="%B%K{039}%F{$black}%F{none}"
    fi

    echo "$pr"
}

is_inside_git ()
{
    if git status &>/dev/null; then
        return 0
    else
        return 1
    fi
}

get_current_dir () {
    dir="%~"
    if is_inside_git; then
        echo shorten_dir $(git rev-parse --show-toplevel)
    else
        echo shorten_dir $dir
    fi
}

setopt PROMPT_SUBST

set_right_prompt () {
    rp=""
# rp+="%b%2~ "
    rp+="%F{$white}%F{$white} %* "
# print the date
    rp+="%F{031}%F{039} %D "
# rp+="$(lsb_release -a | grep Description | cut -d : -f 2 | xargs echo -n)"
    RPROMPT="$rp%K{none}%F{none}"
}

set_left_prompt () {
    p=""
    # print last command status
    p+="%K{015} %B%(?.%F{035}$(check_icon).%F{red}$(exclamation_icon))%b %K{black}%F{015}"

    if is_inside_git; then
        p+="$(git_branch_name)"
    else
        # directory path listing
        p+="%K{$black}%F{green} %~ %K{039}%F{$black}"
        # p+="%K{none}%F{039}"
    fi

    PROMPT="$p%K{039}%F{$black}%B %# %K{none}%F{039}%K{none}%F{none} "
}

set_prompt() {
    set_left_prompt
    set_right_prompt
}
