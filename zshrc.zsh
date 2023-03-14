#!/bin/bash

source $ZDOTDIR/.zprofile

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.cache/.zsh_history
# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS
# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY 

unsetopt autocd

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';; # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.

preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#completion

source $ZDOTDIR/env.zsh
source $ZDOTDIR/completions.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/keybind.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/alias.zsh

precmd() {
    set_prompt
    set_alias
}

welcome() {
    source $ZDOTDIR/.zprofile
}

autoload welcome
zle -N welcome

welcome "todo"


set_fzf_theme ""

#vi: ft=zsh
