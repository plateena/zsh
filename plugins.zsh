#!/bin/bash

source $ZDOTDIR/utils/plug.zsh

echo "" > $ZDOTDIR/data.md

plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "Aloxaf/fzf-tab"
# plug "MichaelAquilina/zsh-you-should-use"
# plug "ohmyzsh/copybuffer"
# plug "ohmyzsh/dirhistory"
# plug "unixorn/git-extra-commands"

source ~/.config/zsh/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

