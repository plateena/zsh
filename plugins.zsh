#!/bin/bash

source $ZDOTDIR/utils/plug.zsh

echo "" > $ZDOTDIR/data.md

plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "djui/alias-tips"
# plug "MichaelAquilina/zsh-you-should-use"
# plug "ohmyzsh/copybuffer"
# plug "ohmyzsh/dirhistory"
# plug "unixorn/git-extra-commands"

eval $(thefuck --alias shoot)

tmrw() {
    timew export work.erp $(w2d $1)
}

source_file
