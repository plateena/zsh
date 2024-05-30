#!/bin/bash

if [[ -z $ZDOTDIR ]]; then
    export ZDOTDIR=$HOME/.config/zsh
else 
fi

source $ZDOTDIR/.zprofile

export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase

if [[ ! -d $HOME/.cache ]]; then
    mkdir $HOME/.cache
fi
if [[ ! -d $HOME/.config ]]; then
    mkdir $HOME/.config
fi
if [[ ! -d $HOME/.local ]]; then
    mkdir $HOME/.local
fi

export HISTFILE=$HOME/.cache/.zsh_history
# History won't save duplicates.
# setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY 

setopt appendhistory
setopt sharehistory
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS


# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';; # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.

preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#completion

source $ZDOTDIR/env.zsh
source $ZDOTDIR/completions.zsh
# source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/keybind.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/alias.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/eza.zsh

#completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# zstyle ':completion:*' menu select
zstyle ':fzf-tab:completion:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'tree $realpath'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


source $ZDOTDIR/fzf-tab.zsh

unsetopt autocd
precmd() {
    set_prompt
    set_alias
}

welcome() {
    source $ZDOTDIR/.zprofile
}

autoload welcome
zle -N welcome

# welcome "todo"


eval "$(fzf --zsh)"
#vi: ft=zsh
