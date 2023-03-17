#!/bin/bash

path=""
path="$HOME/$DOTFILE/npm-global/bin"
path="$HOME/.local/bin:$path"
path="$HOME/bin:$path"
path="/usr/local/bin:$path"
path="/usr/sbin:$path"
path="/usr/bin:$path"
path="/sbin:$path"
path="/bin:$path"
path="/usr/games:$path"
path="/usr/local/games:$path"
path="/snap/bin:$path"

export EDITOR="nvim"
export DOTFILE="$HOME/.dotfiles"

# For fzf environment variable please check fzf.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
# color can be found https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export PATH="$DOTFILE/npm-global/bin:$path"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export NPM_CONFIG_USERCONFIG=$HOME/$DOTFILE/.npmrc
export TASKRC=$XDG_CONFIG_HOME/task/taskrc 
# export TASKDATA=$XDG_DATA_HOME/task
export MYCLI_HISTFILE=$XDG_CACHE_HOME/mycli-history
