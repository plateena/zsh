#!/bin/zsh

# ANSI color code variables
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

# Function: show_neofetch
# Displays neofetch information
function show_neofetch() {
    neofetch
}

# Function: show_cow_fortune
# Displays a fortune cow saying
function show_cow_fortune() {
    fortune | cowsay -pn
}

# Function: show_tux_fortune
# Displays a fortune tux saying
function show_tux_fortune() {
    fortune | cowsay -f tux
}

# Function: show_stegosaurus_fortune
# Displays a fortune stegosaurus saying
function show_stegosaurus_fortune() {
    fortune | cowsay -f stegosaurus 
}

# Ensure the existence of the greetings directory and todo.md file
function ensure_greetings_directory() {
    if [[ ! -d $HOME/.config/zsh/greetings ]]; then
        mkdir $HOME/.config/zsh/greetings
    fi

    if [[ ! -f $HOME/.config/zsh/greetings/todo.md ]]; then
        touch $HOME/.config/zsh/greetings/todo.md
    fi
}

# Function: show_and_update_todo
# Displays and updates the todo list
function show_and_update_todo() {
    todo_file=$HOME/.config/zsh/greetings/todo.md

    echo "" > $todo_file
    echo -e $(ag --color --color-match '0;94m\e[1' --group "@?TODO(?=.+zainundin)" ./ --ignore todo.md --ignore-dir snippet --ignore-dir mysql/data --ignore-dir mysql8/data --ignore-dir sphinx/data 2>&/dev/null | sed 's/^/\\n/') >  $todo_file

    # Source an ASCII art file for visual appeal
    source "$HOME/.config/zsh/ascii/todo.zsh"

    cat "$todo_file"
}

# Function: show_global_todo
# Displays the global todo list
function show_global_todo() {
    todo_file=$HOME/.config/zsh/greetings/todo.md

    if [[ -f $todo_file ]]; then
        echo "" > $todo_file
        echo -e $(ag --color --color-match '0;94m\e[1' --group "@?TODO(?=.+zainundin)" ./ --ignore todo.md --ignore-dir snippet --ignore-dir mysql/data --ignore-dir mysql8/data --ignore-dir sphinx/data 2>&/dev/null | sed 's/^/\\n/') >  $todo_file

        # Source an ASCII art file for visual appeal
        source "$HOME/.config/zsh/ascii/todo.zsh"

        echo ""
        
        # Display the todo list from vimwiki
        tail --lines=+2 "$HOME/vimwiki/Todo.md"
        cat "$todo_file"
    else 
        echo "${red}Error:${reset} Can't display todo list:"
        echo "${red}File ${white}$todo_file ${red}does not exist!"
    fi
}

# Main logic
ensure_greetings_directory

# Command-line argument handling
case "$1" in
    "neofetch")
        show_neofetch
        ;;
    "fcow")
        show_cow_fortune
        ;;
    "ftux")
        show_tux_fortune
        ;;
    "fsor")
        show_stegosaurus_fortune
        ;;
    "todo")
        show_and_update_todo
        ;;
    "global-todo")
        show_global_todo
        ;;
    *)
        # Default action
        ;;
esac
