#!/bin/bash

# ENV 
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase

add_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH}:$1" 
    # else
        # echo "$1 already exist in PATH"
    fi
}

export DOTFILE="$HOME/.dotfiles"
export EDITOR="nvim"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export NPM_CONFIG_USERCONFIG=$HOME/$DOTFILE/.npmrc
export TASKRC=$XDG_CONFIG_HOME/task/taskrc 

add_path "/bin"
add_path "/usr/bin"
add_path "/usr/sbin"
add_path "/sbin"
add_path "/usr/games"
add_path "/usr/local/games"
add_path "/usr/local/bin"
add_path "/snap/bin"
add_path "$HOME/.local/bin"
add_path "$HOME/plateena/bin"
add_path "$HOME/bin"
add_path "$DOTFILE/npm-global/bin"

if [[ -n $HOME/.local/share/firefox/firefox ]]; then
    add_path "$HOME/.local/share/firefox/firefox"
fi


# For fzf environment variable please check fzf.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
# color can be found https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export MYCLI_HISTFILE=$XDG_CACHE_HOME/mycli-history
