#!/bin/zsh

# FZF Configuration

# Default command for FZF file selection
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'

# FZF_CTRL_T: File selection with preview using bat
export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d)' \
    --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# FZF_ALT_C: Directory selection with tree preview
export FZF_ALT_C_OPTS="
--preview 'tree -C {}'
--bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d)' \
    --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)'
    "

# FZF_CTRL_R: Command history search with bat preview
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

# Default options for FZF
export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Function to set FZF theme
function set_fzf_theme() {
    case "$1" in
        "seoul256")
            # junegunn/seoul256.vim (dark)
            # export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#3F3F3F,..."
            ;;
        "gruvbox")
            # morhetz/gruvbox
            export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#3c3836,..."
            ;;
        "nord-vim")
            # arcticicestudio/nord-vim
            export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#3B4252,..."
            ;;
        "molokai")
            # tomasr/molokai
            export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#293739,..."
            ;;
        *)
            # Default theme
            export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"
            ;;
    esac
}

# Documentation:
# FZF_CTRL_T_OPTS: File selection with preview using bat
# FZF_ALT_C_OPTS: Directory selection with tree preview
# FZF_CTRL_R_OPTS: Command history search with bat preview

# FZF_DEFAULT_OPTS: Default options for FZF

# set_fzf_theme: Function to set the FZF theme based on the given argument
#   - Usage: set_fzf_theme "theme_name"

# Note: Ensure this script is sourced in your Zsh configuration.
