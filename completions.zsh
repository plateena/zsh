#!/bin/bash

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

if [[ -f $XDG_CONFIG_HOME/zsh/completion/fzf.zsh ]]; then
    source $XDG_CONFIG_HOME/zsh/completion/fzf.zsh
fi
#vi: ft=zsh
