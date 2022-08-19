#!/bin/bash

BACKUP_PATH="/home/vetse/Notes/Railnova/Todos/"
TODO_PATH="/home/vetse/Documents/insync/todos.md"

[ ! -f "$TODO_PATH" ] && echo "ERROR" && exit 1

function count() {
    full=$(grep -Pc "^\*?\[[xX ]\]" <$TODO_PATH)
    done=$(grep -Pc "^\*?\[[xX]\]" <$TODO_PATH)

    urgent_all=$(grep -Pc "^\*\[[xX ]\]" <$TODO_PATH)
    urgent_done=$(grep -Pc "^\*\[[xX]\]" <$TODO_PATH)

    projects=$(grep -Pc "^[#]{2}" <$TODO_PATH)

    if [ "$full" -eq 0 ]; then
        echo "%{F#f00}NO TODO%{F-} [${projects}]"
        return 0
    fi

    if [ "$full" -eq "$done" ]; then
        echo "%{F#0F0}DONE%{F-} [${projects}]"
        return 0
    fi

    echo "%{F#0F3}${projects}%{F-} %{F#EEE}—${F-} %{F#F22}${urgent_done}/${urgent_all}%{F-} %{F#EEE}—${F-} %{F#99F}${done}/${full}%{F-}"
    return 0
}

function edit() {
    alacritty -e nvim $TODO_PATH
    exit 0
}

function backup() {
    # cp -L $TODO_PATH "$BACKUP_PATH"/todos_"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    sed -i -E '/^\*?\[[xX]\]/d' $TODO_PATH
    sed -i -E '/<!--/d' $TODO_PATH
    sed -i -E '/^$/N;/^\n$/d' $TODO_PATH
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
