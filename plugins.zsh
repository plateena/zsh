#!/bin/bash

source $ZDOTDIR/utils/plug.zsh

echo "" > $ZDOTDIR/data.md

plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
# plug "MichaelAquilina/zsh-you-should-use"
# plug "ohmyzsh/copybuffer"
# plug "ohmyzsh/dirhistory"
# plug "unixorn/git-extra-commands"

source_file
