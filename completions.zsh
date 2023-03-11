#!/bin/bash

echo "zsh_completion loaded"
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

#vi: ft=zsh
