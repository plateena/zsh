#!/bin/bash

# set env and path
source $ZDOTDIR/env.zsh
# Add custom directory to fpath
fpath=(~/.config/zsh/completions $fpath)

autoload -U compinit; compinit

# OPTIONS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt appendhistory
setopt sharehistory
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Setup cache and .zsh_history
if [[ ! -d $HOME/.cache ]]; then
    mkdir $HOME/.cache
fi
if [[ ! -d $HOME/.config ]]; then
    mkdir $HOME/.config
fi
if [[ ! -d $HOME/.local ]]; then
    mkdir $HOME/.local
fi

export HISTFILE=$HOME/.cache/.zsh_history


# FZF for fuzzy finder
source $ZDOTDIR/fzf.zsh

# Setup prompt visual
source $ZDOTDIR/prompt.zsh

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

# Plugins
# plugin need to be load after compinit
autoload -U compinit; compinit

# set vi binding
source $ZDOTDIR/keybind.zsh

source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/alias.zsh

