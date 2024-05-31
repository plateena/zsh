#!/bin/bash

plugin_path="$ZDOTDIR/plugins"

source_file() {
    local plugin=$(echo $1 | cut -f2 -d /)
    local file="$plugin_path/$1/$plugin"

    if [[ -f "$file.plugin.zsh" ]]; then
        file="$file.plugin.zsh"
    elif [[ -f "$file.zsh" ]]; then
        file="$file.zsh"
    elif [[ -f "$file.plugins.zsh" ]]; then
        file="$file.plugins.zsh"
    fi

    if [[ -f "$file" ]]; then
        source "$file"
        echo " * Plugin $1 loaded." >> $ZDOTDIR/data.md 
    fi
}

plug () {
    if [ -d "$plugin_path/$1" ] 
    then
        # echo "plugin $1 already install" 
        source_file "$1"
        if [ -f "$ZDOTDIR/plugin_config/$1.zsh" ]
        then
            # echo "Load config for plugins $1"
            source "$ZDOTDIR/plugin_config/$1.zsh"
        # else
            # echo "No config for $1"
        fi
    else 
        echo "Installing plugin $1"
        git clone "git@github.com:$1.git"  "$plugin_path/$1" 
        echo "Done installing $1"
    fi
}
