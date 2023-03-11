#!/bin/bash

# can checkot color at https://www.tweaking4all.com/software/macosx-software/xterm-color-cheat-sheet/
black="235"
white="015"

echo "prompt loaded"
autoload -Uz vcs_info

zstyle ':vcs_info:git:*' formats '%b '

function git_branch_name() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
}

precmd() { vcs_info }
precmd() { git_branch_name }
echo "the branch is $branch"

setopt PROMPT_SUBST

p=""
p+="%K{$white}%B %(?.%F{035}√.%F{red}!)%b %K{black}%F{$white}"
p+="%K{$black}%F{green} %~ %K{039}%F{$black}"
# p+="%K{039}%F{015} |%(${vcs_info_msg_0_}=='master'.'sdf'.'D')| "
p+="%K{039}%F{015} $(echo "$branch")"

p+="%K{none}%F{039}"

PROMPT="$p %# %K{none}%F{none}"

rp=""
rp+="%b%2~ "
rp+="%K{none}%F{$white}%B%K{$white}%F{$black} %* "
# h for history number
rp+="%K{$white}%F{040}%K{040}%F{$black} %D %h"
rp+=" %F{016}%B%b"
RPROMPT="$rp%K{none}%F{none}"
