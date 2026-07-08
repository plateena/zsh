#!/bin/zsh

source $ZDOTDIR/bin/shortendir.zsh

# Cached git state (populated in precmd)
typeset -g _git_branch=""
typeset -g _git_dirty=""
typeset -g _git_toplevel=""
typeset -g _git_prefix=""
typeset -g _is_git=0

_cache_git_info() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        _is_git=1
        _git_branch=$(git branch --show-current 2>/dev/null)
        _git_toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
        _git_prefix=$(git rev-parse --show-prefix 2>/dev/null)
        _git_prefix=${_git_prefix%/}

        if git diff --quiet HEAD 2>/dev/null && [[ -z "$(git status --porcelain --untracked-files=no 2>/dev/null)" ]]; then
            _git_dirty=0
        elif ! git diff --quiet 2>/dev/null; then
            _git_dirty=2
        else
            _git_dirty=1
        fi
    else
        _is_git=0
        _git_branch=""
        _git_dirty=""
        _git_toplevel=""
        _git_prefix=""
    fi
}

_prompt_dir() {
    if (( _is_git )); then
        local dir=$(shorten_dir "$_git_toplevel" 20)
        echo "$dir"
    else
        local home_icon=$'\U000f02dc'
        local dir="${PWD/$HOME/$home_icon}"
        echo "$dir"
    fi
}

_prompt_git_segment() {
    (( _is_git )) || return

    local color
    case $_git_dirty in
        0) color="036" ;;  # clean
        1) color="166" ;;  # staged/untracked
        2) color="196" ;;  # unstaged changes
    esac

    local segment="%F{$color}\ue725 $_git_branch%f"

    if [[ -n "$_git_prefix" ]]; then
        local prefix=$(shorten_dir "$_git_prefix" 10)
        segment+=" %F{green}$prefix%f"
    fi

    echo "$segment"
}

set_right_prompt() {
    local rp=""
    rp+="%F{067} $(_prompt_dir) "
    rp+="%F{015}󰥔 %* "
    rp+="%F{039}󰃭 %D{%-d-%b}"

    if (( _is_git )); then
        rp+=" $(_prompt_git_segment)"
    fi

    RPROMPT="$rp%f"
}

set_left_prompt() {
    local icon=$(printf '\uf4b5')
    PROMPT="%K{none} %(?.%F{047}.%F{red})${icon} %B%K{none}%F{none} "
}

_prompt_precmd() {
    print -P "%F{237}${(r:$COLUMNS::-:)}%f"
    _cache_git_info
    set_left_prompt
    set_right_prompt
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_precmd
