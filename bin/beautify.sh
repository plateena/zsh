#!/bin/bash

# Text Styles 	 Commands
# Foreground color 	setaf
# Background color 	setab
# No style 	sgv0
# Bold text 	bold
# Low-intensity text 	dim
# Underline text 	smul
# Blinking text 	blink
# Reverse text 	rev

# YELLOW=`tput setaf 3`
# echo "${YELLOW}Changing"
# WHITE=`tput setaf 7 bold`
# echo "${WHITE}Colors"
# BLUE=`tput setaf 4 smul`
# echo "${BLUE}With tput"
# CYAN=`tput setaf 6 blink`
# echo "${CYAN}is less"
# RED=`tput setab 1 setaf 7`
# echo "${RED}verbose!"


print_color() {
    color_count=$(($(tput colors) -1))
    for c in $(seq 0 $color_count)
    do
        n=$c
        if [[ "${#c}" = 1 ]]; then
            n="$c  "
        elif [[ "${#c}" = 2 ]]; then
            n="$c "
        fi

        echo -n "`tput setaf $c`tput setaf $n       "

        if [[ $(expr $c % 8) == 0 ]]; then
            echo ""
        fi
    done
}

print_color
