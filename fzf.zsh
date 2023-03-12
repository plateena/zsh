#!/bin/bash

# fzf
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
# export FZF_CTRL_T_COMMAND="command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d)' \
    --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
--preview 'tree -C {}'
--bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d)' \
    --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)'
    "

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"

function set_fzf_theme() {
    if [[ "$1" == "seoul256" ]] then
        # junegunn/seoul256.vim (dark)
        # export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#3F3F3F,bg:#4B4B4B,border:#6B6B6B,spinner:#98BC99,hl:#719872,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,preview-bg:#3F3F3F,prompt:#98BEDE,hl+:#98BC99"
    elif [[ "$1" == "gruvbox" ]] then
        # morhetz/gruvbox
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934"
    elif [[ "$1" == "nord-vim" ]] then
        # arcticicestudio/nord-vim
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"
    elif [[ "$1" == "nord-vim" ]] then
        # tomasr/molokai
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672"
    else
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"
    fi
}
