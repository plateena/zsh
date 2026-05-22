

export UID=$(id -u)
export GID=$(id -g)

add_path() {
  [[ ":$PATH:" == *":$1:"* ]] || PATH="$PATH:$1"
}

export NVM_DIR="$HOME/.config/nvm"
_lazy_nvm() {
  unset -f node npm nvm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}
for _cmd in node npm nvm npx; do
  eval "${_cmd}() { _lazy_nvm; ${_cmd} \"\$@\" }"
done
unset _cmd

export DOTFILE="$HOME/.dotfiles"
export EDITOR="nvim"
export VISUAL="nvim"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LARAVEL_BASE_IMAGE="471112561530.dkr.ecr.ap-southeast-1.amazonaws.com/php-laravel-compat"

export NVIM_LOG_LEVEL=debug
export NVIM_LOG_FILE="/var/log/nvim.log"

export NPM_CONFIG_USERCONFIG="$HOME/$DOTFILE/.npmrc"
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"

export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LC_MONETARY="en_GB.UTF-8"

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

export CHEAT_CONFIG_PATH="~/.config/cheat/conf.yml"

# Use user-local gem install path
export GEM_HOME="$HOME/.local/share/gems"
export GEM_PATH="$HOME/.local/share/gems"

export PATH="$PATH:$(go env GOPATH)/bin"

add_path "/bin"
add_path "/usr/bin"
add_path "/usr/sbin"
add_path "/sbin"
add_path "/usr/games"
add_path "/usr/local/games"
add_path "/usr/local/bin"
add_path "/opt/nvim"
add_path "/snap/bin"

add_path "$HOME/.local/bin"
add_path "$HOME/.config/zsh/bin"
add_path "$HOME/plateena/bin"
add_path "$HOME/bin"
add_path "$DOTFILE/npm-global/bin"

add_path "$HOME/.rbenv/versions/3.0.4/bin"
add_path "$HOME/.rbenv/bin"

add_path "$HOME/.config/herd-lite/bin"
add_path "$HOME/.config/composer/vendor/bin"
add_path "$HOME/.local/share/nvim/mason/bin"
add_path "$HOME/.local/share/gems/bin"
add_path "$HOME/.local/share/gem/ruby/3.2.0/bin"

[[ -x "$HOME/.local/share/firefox/firefox" ]] && add_path "$HOME/.local/share/firefox"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export MYCLI_HISTFILE="$XDG_CACHE_HOME/mycli-history"

unset SSH_ASKPASS
unset SSH_ASKPASS_REQUIRE

rbenv() {
  unset -f rbenv
  eval "$(command rbenv init -)"
  rbenv "$@"
}
