#!/bin/zsh

# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"

# --- Environment ---
source $ZDOTDIR/env.zsh

# Add custom completions
fpath=(~/.config/zsh/completions $fpath)

# --- History Setup (atuin handles search; this is fallback/file-based) ---
export HISTFILE=$HOME/.cache/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt appendhistory

# Ensure history file exists
mkdir -p ${HISTFILE:h}

# --- Cache / Config dirs ---
mkdir -p $HOME/.cache $HOME/.config $HOME/.local

# --- FZF & Prompt ---
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/prompt.zsh

# --- Cursor Shape for vi mode ---
function zle-keymap-select {
  case $KEYMAP in
  vicmd) echo -ne '\e[1 q' ;;        # block
  viins | main) echo -ne '\e[5 q' ;; # beam
  esac
}
zle -N zle-keymap-select

function zle-line-init {
  zle -K viins
  echo -ne '\e[5 q'
}
zle -N zle-line-init

preexec() { echo -ne '\e[5 q'; }
echo -ne '\e[5 q' # initial beam cursor

# --- Keybinds, Plugins, Aliases ---
source $ZDOTDIR/keybind.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/alias.zsh

# --- Compinit (after plugins so all completions are registered) ---
autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
  compinit -d "$ZDOTDIR/.zcompdump"
else
  compinit -C -d "$ZDOTDIR/.zcompdump"
fi

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"
