#!/bin/bash

BACKUP_PATH="/home/vetse/Notes/Railnova/Todos/"
TODO_PATH="/home/vetse/Documents/insync/todos.md"

[ ! -f "$TODO_PATH" ] && echo "ERROR" && exit 1

function count() {
    full=$(grep -Pc "^\[[xX ]\]" <$TODO_PATH)
    done=$(grep -Pc "^\[[xX]\]" <$TODO_PATH)
    projects=$(grep -Pc "^[#]{2}" <$TODO_PATH)

    if [ "$full" -eq 0 ]; then
        echo "%{F#f00}NO TODO%{F-} [${projects}]"
        return 0
    fi

    if [ "$full" -eq "$done" ]; then
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
    cp -L $TODO_PATH "$BACKUP_PATH"/todos_"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    sed -i '/^\[[xX]\]/d' $TODO_PATH
    sed -i '/^$/N;/^\n$/D' $TODO_PATH
    exit 0
}

case "${1}" in
"edit")
    edit
    ;;
"backup")
    backup
    ;;
*)
    count
    ;;
esac
