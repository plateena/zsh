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

export DOTFILE="$HOME/.dotfiles"

# For fzf environment variable please check fzf.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
# color can be found https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export PATH="$DOTFILE/npm-global/bin:$path"
