#!/bin/bash

plugin_path="$ZDOTDIR/plugins"
function plug () {
    if [ -d "$plugin_path/$1" ] 
    then
        # echo "plugin $1 already install" 
        plugin=$(echo $1 | cut -f2 -d /)
        source "$plugin_path/$1/$plugin.zsh"
        echo "Plugin $1 loaded." >> $ZDOTDIR/data.md 
    else 
        echo "Installing plugin $1"
        git clone "git@github.com:$1.git"  "$plugin_path/$1" 
        echo "Done installing $1"
    fi
}
