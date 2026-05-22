#!/bin/zsh

source $ZDOTDIR/utils/plug.zsh

echo "" >$ZDOTDIR/data.md

plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "djui/alias-tips"
# plug "MichaelAquilina/zsh-you-should-use"
# plug "ohmyzsh/copybuffer"
# plug "ohmyzsh/dirhistory"
# plug "unixorn/git-extra-commands"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
  unset -f pyenv
  eval "$(command pyenv init - zsh)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}

eval "$(zoxide init zsh)"

