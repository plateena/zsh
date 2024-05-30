#!/bin/zsh

eval "$(fzf --zsh)"

# # FZF Configuration
#
# # Default command for FZF file selection
FD_FLAGS="--strip-cwd-prefix --follow"
FD_EXCLUDE_GIT="--exclude .git"
FD_EXCLUDE_HIDDEN="--hidden"
FD_FILE_CMD="fd -t f $FD_EXCLUDE_HIDDEN $FD_EXCLUDE_GIT"
FD_DIR_CMD="fd -t d $FD_EXCLUDE_HIDDEN $FD_EXCLUDE_GIT"
export FZF_DEFAULT_COMMAND="fd $FD_FLAGS $FD_EXCLUDE_HIDDEN $FD_EXCLUDE_GIT"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FD_DIR_CMD"

# ** completion
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always --icons=always {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always --line-range :500 {}' "$@" ;;
  esac
}

MY_FZF_DEFAULT_OTPS="
--bind 'ctrl-d:change-prompt(Directories ▶ )+reload($FD_DIR_CMD)'
--bind 'ctrl-f:change-prompt(Files ▶ )+reload($FD_FILE_CMD)'
--bind 'ctrl-s:change-prompt(All ▶ )+reload($FZF_DEFAULT_COMMAND)'
--bind 'ctrl-/:toggle-preview'
--header 'Press CTRL-Y to copy command into clipboard'
--color header:italic
--layout=reverse --info=inline --border --margin=1 --padding=1
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
"

MY_FZF_COPY_OPTS="
--bind 'ctrl-y:execute(readlink -f {} | xclip -selection clipboard)+abort'
--bind 'ctrl-alt-y:execute-silent(xclip -selection clipboard {})+abort'
"

export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always --line-range :500 {}'
$MY_FZF_COPY_OPTS
--prompt='All ▶ '
"
export FZF_CTRL_C_OPTS="
--preview 'eza --tree --color=always --icons=always {} | head 200'
$MY_FZF_COPY_OPTS
--prompt='Files ▶ '
"
export FZF_CTRL_R_OPTS="
--prompt='Command ▶ '
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
"

export FZF_DEFAULT_OPTS="$MY_FZF_DEFAULT_OTPS"
