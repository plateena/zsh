#!/bin/bash

get_max_length() {
    if [[ ! -z $2 ]]; then
        local max_length=$2
    else
        local max_length=200
    fi

    depth=$(get_depth "$1")
    depth=$(echo "$depth * 3" | bc)
    if [[ $max_length -gt $depth ]]; then
        echo $max_length
    else
        echo $depth
    fi
}

swap_homes(){
    echo $1 | sed -e "s|$HOME|~|"
}

get_depth() {
    dirs=(echo $(rep_to_space_delim "$1"))
    local depth=${#dirs[@]}
    echo ${depth}
}

rep_to_space_delim() {
    echo $1 | sed -e "s|\/| |g"
}

shorten_dir() {
    pt=$(swap_homes "$1")
    if [[ ${#pt} = 0 ]]; then
        return 1
    fi

    maxl=$(get_max_length "$pt" $2)

    bname=$(basename $pt)
    dirs=($(rep_to_space_delim $pt))
    c=0
    while [[ ! $c -eq $(get_depth $pt) ]]; do
        newdir=""

        for i in "${dirs[@]}"
        do
            if [[ ${dirs[$c]} = $i ]]; then
                if [[ $i == .* ]]; then
                    newdir+="${i:0:2}"
                else
                    newdir+="${i:0:1}"
                fi
            else
                newdir+="$i"
            fi
            newdir+="/"
        done

        if [[ ${#newdir} -lt $maxl ]]; then
            break
        fi

        dirs=($(rep_to_space_delim $newdir))

        c=$(echo "$c + 1" | bc )
        # stop when reaching the end of dir
        if [[ ${dirs[$c]} == $bname ]]; then
            break
        fi
    done

    echo "$(echo $newdir | sed 's/\/$//' )"
}

# shorten_dir "/home/zack/.sandbox/.repositories/codes/hws-console/src/app/View/Components" "100"
