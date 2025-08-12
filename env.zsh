#!/bin/bash

# ENV
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase

# Set UID and GID for Docker development
export UID=$(id -u)
export GID=$(id -g)

# export NODE_BASE_IMAGE="471112561530.dkr.ecr.ap-southeast-1.amazonaws.com/node:latest"
# export LARAVEL_BASE_IMAGE="471112561530.dkr.ecr.ap-southeast-1.amazonaws.com/php-laravel-compat:latest"

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

export NVIM_LOG_LEVEL=debug
export NVIM_LOG_FILE=~/nvim.log

export NPM_CONFIG_USERCONFIG=$HOME/$DOTFILE/.npmrc
export TASKRC=$XDG_CONFIG_HOME/task/taskrc
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_MONETARY=en_GB.UTF-8

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
# export ZSH_PLUGINS_ALIAS_TIPS_FORCE=1

# Function to add to PATH only if not already present

# Standard system paths
add_path "/bin"
add_path "/usr/bin"
add_path "/usr/sbin"
add_path "/sbin"
add_path "/usr/games"
add_path "/usr/local/games"
add_path "/usr/local/bin"
add_path "/snap/bin"

# User paths
add_path "$HOME/.local/bin"
add_path "$HOME/plateena/bin"
add_path "$HOME/bin"
add_path "$DOTFILE/npm-global/bin"

# rbenv-specific paths (only if directories exist)
add_path "$HOME/.rbenv/versions/3.0.4/bin"
add_path "$HOME/.rbenv/bin"

# Other tools
add_path "$HOME/.config/herd-lite/bin"
add_path "$HOME/.config/composer/vendor/bin"
add_path "$HOME/.local/share/nvim/mason/bin"

# Conditionally add Firefox path if the file exists and is executable
if [[ -x "$HOME/.local/share/firefox/firefox" ]]; then
  add_path "$HOME/.local/share/firefox"
fi

# For fzf environment variable please check fzf.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
# color can be found https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export MYCLI_HISTFILE=$XDG_CACHE_HOME/mycli-history

# Added by `rbenv init` on Mon 12 May 20:26:46 +08 2025
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
