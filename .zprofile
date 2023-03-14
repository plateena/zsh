#!/bin/bash

# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

if [[ "$1" = "neofetch" ]]; then
    neofetch
fi

if [[ "$1" = "fcow" ]]; then
    fortune | cowsay -pn
fi

if [[ "$1" = "ftux" ]]; then
    fortune | cowsay -f tux
fi

if [[ "$1" = "fsor" ]]; then
    fortune | cowsay -f stegosaurus 
fi

if [[ "$1" = "todo" ]]; then
    todo_file=$HOME/.config/zsh/greetings/todo.md
    echo "" > $todo_file
    echo -e $(ag --color --color-match '0;94m\e[1' --group "(TODO).+zainundin" ./ --ignore-dir snippet | sed 's/^/\\n/') >  $todo_file
    # nvim "$todo_file" -c "g/:#/norm 0i    " -c wq
    source "$HOME/.config/zsh/ascii/todo.zsh"
    cat "$todo_file"
fi

if [[ "$1" = "global-todo" ]]; then
    todo_file=$HOME/.config/zsh/greetings/todo.md
    echo "" > $todo_file
    echo -e $(ag --color --color-match '0;94m\e[1' --group "(TODO).+zainundin" ./ --ignore "todo.md" --ignore-dir snippet | sed 's/^/\\n/') >  $todo_file
    # nvim "$todo_file" -c "g/:#/norm 0i    " -c wq
    source "$HOME/.config/zsh/ascii/todo.zsh"

    echo ""

    tail --lines=+2 "$HOME/vimwiki/Todo.md"
    cat "$todo_file"
fi
