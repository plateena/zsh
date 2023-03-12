#!/bin/bash

# can checkot color at https://www.tweaking4all.com/software/macosx-software/xterm-color-cheat-sheet/
black="235"
white="015"
# dir_arrow_end_bg="039"
dir_arrow_end_bg="039"

autoload -Uz vcs_info
#
zstyle ':vcs_info:git:*' formats '%b '

source $ZDOTDIR/scripts/shortendir.sh

git_branch_name () {
    branch=$(git branch --show-current)
    local bg="red"
    local prefix=$(git rev-parse --show-prefix | sed 's/\/$//')
    local pr=""
    local dir=$(git rev-parse --show-toplevel)

    if [[ $(git diff) ]]; then
        bg="196"
    else
        bg="166"
    fi

    if [ -z "$(git status --porcelain)" ]; then
        bg="036"
    fi

    dir_arrow_end_bg="$bg"

    dir=$(shorten_dir $dir 20)

    if [[ ! -z "$prefix" ]]; then
        prefix=$(shorten_dir $prefix 10)
    fi

    pr+="%K{$black}%F{green} $dir %K{$bg}%F{$black}%K{$bg}%F{015} $branch %K{$black}%F{$bg}"
    if [ ! -z "$prefix" ]; then
        pr+=" %F{green}$prefix %K{039}%F{$black}%F{none}"
    else
        pr+="%K{039}%F{$black}%F{none}"
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
    p+="%K{$white}%B %(?.%F{035}√.%F{red}!)%b %K{black}%F{$white}"

    if is_inside_git; then
        p+="$(git_branch_name)"
    else
        p+="%K{$black}%F{green} %~ %K{039}%F{$black}"
        p+="%K{none}%F{039}"
    fi


    PROMPT="$p %# %K{none}%F{039}%K{none}%F{none} "
}

set_prompt() {
    set_left_prompt
    set_right_prompt
}
