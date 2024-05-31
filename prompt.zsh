#!/bin/zsh

# Color codes for prompt
black="235"
white="015"
dir_arrow_end_bg="039"

# Source the script for shortening directories
source $ZDOTDIR/bin/shortendir.sh

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

# Function to display the git branch information in the prompt
git_branch_name() {
    local branch=$(git branch --show-current)
    local bg="red"
    local prefix=$(git rev-parse --show-prefix | sed 's/\/$//')
    local pr=""
    local dir=$(git rev-parse --show-toplevel)

    # Check if the git status has differences
    if [[ $(git diff) ]]; then
        bg="196"
    else
        bg="166"
    fi

    # Check if the current git status is clean
    if [ -z "$(git status --porcelain)" ]; then
        bg="036"
    fi

    dir_arrow_end_bg="$bg"

    dir=$(shorten_dir $dir 20)

    if [[ ! -z "$prefix" ]]; then
        prefix=$(shorten_dir $prefix 10)
    fi

    # Constructing the prompt string
    pr+="%K{$black}%F{green} $dir %K{$bg}%F{$black}"
    pr+="%K{$bg}%F{015} %B$(branch_icon) $branch %K{$black}%F{$bg}"

    if [ ! -z "$prefix" ]; then
        pr+=" %F{green}$prefix %K{039}%F{$black}%F{none}"
    else
        pr+="%B%K{039}%F{$black}%F{none}"
    fi

    echo "$pr"
}

# Function to check if the current shell is inside a git repository
is_inside_git() {
    git status &>/dev/null
}

# Function to get the current directory
get_current_dir() {
    dir="%~"
    if is_inside_git; then
        echo shorten_dir $(git rev-parse --show-toplevel)
    else
        echo shorten_dir $dir
    fi
}

# Function to set the right prompt
set_right_prompt() {
    rp=""
    rp+="%F{015}%F{015} %* "
    rp+="%F{031}%F{039} %D "
    RPROMPT="$rp%K{none}%F{none}"
}

# Function to set the left prompt
set_left_prompt() {
    p=""
    p+="%K{015} %B%(?.%F{035}$(check_icon).%F{red}$(exclamation_icon))%b %K{black}%F{015}"

    if is_inside_git; then
        p+="$(git_branch_name)"
    else
        p+="%K{$black}%F{green} %~ %K{039}%F{$black}"
    fi

    PROMPT="$p%K{039}%F{$black}%B %# %K{none}%F{039}%K{none}%F{none} "
}

# Function to set the complete prompt
set_prompt() {

    # Add line before prompt
    precmd() { 
        echo -e "\033[40;33m${(r:$COLUMNS:: :)}"
    }

    set_left_prompt
    set_right_prompt
}

# Run the set_prompt function
set_prompt
