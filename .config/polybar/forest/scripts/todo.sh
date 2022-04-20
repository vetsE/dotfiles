#!/bin/bash

TODO_PATH="/home/vetse/todos.md"
BACKUP_PATH="/home/vetse/Notes/Railnova/Todos"

function count() {
    full=$(cat $TODO_PATH|grep -Pc "^\[[xX ]\]")
    done=$(cat $TODO_PATH|grep -Pc "^\[[xX]\]")
    projects=$(cat $TODO_PATH|grep -Pc "^[#]{2}")

    if [ "$full" -eq 0 ]
    then
        echo "%{F#f00}NO TODO%{F-} [${projects}]"
        return 0
    fi

    if [ "$full" -eq "$done" ]
    then
        echo "%{F#0F0}DONE%{F-} [${projects}]"
        return 0
    fi

    echo "TODO: %{F#FDF}${done}/${full}%{F-} [${projects}]"
    return 0
}


function edit() {
    konsole -e nvim $TODO_PATH
    exit 0
}

function backup() {
    mv $TODO_PATH ${TODO_PATH}_
    cat ${TODO_PATH}_ | grep -v "^\[xX\]" > $TODO_PATH
    mv ${TODO_PATH}_ $BACKUP_PATH/todos_"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    exit 0
}

# if [ -n "$TODO_PATH" ]
# then
#     touch $TODO_PATH
# fi

[ "$1" == "edit" ] && edit
[ "$1" == "backup" ] && backup

count
