#!/bin/zsh

shorten_dir() {
    local input="${1}"
    local max_length="${2:-200}"

    # Replace $HOME with home icon (MD icons range for consistent size)
    local home_icon=$'\U000f02dc'
    local pt="${input/$HOME/$home_icon}"
    [[ -z "$pt" ]] && return 1

    # Calculate depth-based minimum
    local -a parts=("${(@s:/:)pt}")
    local depth=${#parts[@]}
    local depth_limit=$(( depth * 3 ))
    (( max_length < depth_limit )) && max_length=$depth_limit

    local bname="${pt:t}"

    # Progressively shorten from left
    local i
    for (( i = 1; i <= depth; i++ )); do
        (( ${#pt} <= max_length )) && break
        [[ "${parts[$i]}" == "$bname" ]] && break

        if [[ "${parts[$i]}" == .* ]]; then
            parts[$i]="${parts[$i]:0:2}"
        else
            parts[$i]="${parts[$i]:0:1}"
        fi

        pt="${(j:/:)parts}"
    done

    echo "$pt"
}
