source ~/.config/zsh/colors.zsh

function imhere() {
    while true; do
        xdotool mousemove_relative --sync 1 0 2 &>/dev/null
        sleep 1
        xdotool mousemove_relative --sync -- -1 0 2 &>/dev/null
        sleep 1
    done
}

function search() {
    case $# in
    1)
        pattern="$1"
        context=30
        match=""
        ;;
    2)
        pattern="$2"
        context=30
        match="**/*.$1"
        ;;
    3)
        pattern="$3"
        context="$2"
        match="**/*.$1"
        ;;
    *)
        echo "$fg[yellow]Usage: search [extension [context]] <pattern>"
        return 1
        ;;
    esac

    grep --color=always -rnoEI ".{0,$context}${pattern}.{0,$context}" "$match"
    return $?
}

function search_file() {
    if [[ $# -eq 1 ]]; then
        pattern=$1
        find -name "*$1*"
        return $?
    fi
    echo "$fg[yellow]Usage: search_file <pattern>"
    return 1
}

function copy_from_server() {
    if [[ $# -eq 2 ]]; then
        source=$1
        destination=$2
        rsync -aHAXx --progress --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" pereat:/home/deleo/"$source" "$destination"
        # rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" pereat:/home/deleo/$source $destination
        return $?
    fi

    echo "$fg[yellow]Usage: copy_from_server <source> <destination>"
    return 1
}

function goodbye() {
    color=$(
        tput bold
        tput setaf 7
    )
    normal=$(tput sgr0)
    echo "${color}See You Space Cowboy...${normal}"
    sleep 0.25
}

function spinner() {
    # make sure we use non-unicode character type locale
    # (that way it works for any locale as long as the font supports the characters)
    local LC_CTYPE=C

    local pid=$1 # Process Id of the previous running command
    local choice=9

    # case $(($RANDOM % 12)) in
    case $choice in
    0)
        local spin='⠁⠂⠄⡀⢀⠠⠐⠈'
        local charwidth=3
        ;;
    1)
        local spin='-\|/'
        local charwidth=1
        ;;
    2)
        local spin="▁▂▃▄▅▆▇█▇▆▅▄▃▂▁"
        local charwidth=3
        ;;
    3)
        local spin="▉▊▋▌▍▎▏▎▍▌▋▊▉"
        local charwidth=3
        ;;
    4)
        local spin='←↖↑↗→↘↓↙'
        local charwidth=3
        ;;
    5)
        local spin='▖▘▝▗'
        local charwidth=3
        ;;
    6)
        local spin='┤┘┴└├┌┬┐'
        local charwidth=3
        ;;
    7)
        local spin='◢◣◤◥'
        local charwidth=3
        ;;
    8)
        local spin='◰◳◲◱'
        local charwidth=3
        ;;
    9)
        local spin='◴◷◶◵'
        local charwidth=3
        ;;
    10)
        local spin='◐◓◑◒'
        local charwidth=3
        ;;
    11)
        local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
        local charwidth=3
        ;;
    12)
        local spin='✶✸✹✺✹✷'
        local charwidth=3
        ;;
    esac

    local i=0
    tput civis # cursor invisible
    while kill -0 "$pid" 2>/dev/null; do
        local i=$(((i + charwidth) % ${#spin}))
        printf "%s" "$green${spin:i:charwidth}""$normal"
        echo -en "\033]30;${spin:i:charwidth}\007"
        echo -en "\033[1D"
        sleep .1
    done
    tput cnorm
    wait "$pid"
    return $?
}

function now() {
    date +"%H:%M:%S"
}

function printline() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function watch_and_make_tex() {
    set +m
    [ ! -d "./tex" ] && echo "${red}Couldn't find a 'tex' directory.""$normal" && return 1

    while true; do
        inotifywait -e modify "./tex" 2>/dev/null
        echo -n "${green}Making ""$(basename "$PWD") (""$(now)) ""$normal"
        make >/tmp/wam.log 2>&1 &
        spinner $!
        if [[ $? -eq 0 ]]; then
            echo "$green[OK]""$normal"
            echo -ne "\033]30;[OK] $(now) \007"
        else
            echo "$red[ERROR]""$normal"
            echo -ne "\033]30;[ERROR] $(now) \007"
            cat /tmp/wam.log | grep "^l\.[0-9]\+"
            rm /tmp/wam.log
        fi
        sleep 0.5
    done
    set -m
}

function watch_and_make() {

    [ ! $# -eq 1 ] && echo "${red}Need a file to watch.""$normal" && return 1

    watch_and_do "$1" "make"
}

function watch_and_run() {
    [ ! $# -eq 1 ] && echo "Usage: '${green}watch_and_run <file>'""$normal." && return 1
    [[ ! -f $1 ]] && echo "$red\"$1\" needs to be a valid file.""$normal" && return 1

    ext="${1##*.}"
    case "$ext" in
    "py")
        watch_and_do "$1" python "$1"
        ;;
    "sh")
        watch_and_do "$1" bash "$1"
        ;;
    *)
        echo "${red}Doesn't know how to run this extension: $ext"
        return 1
        ;;
    esac

}

function watch_and_do() {

    [[ ! -e $1 ]] && echo "$red\"$1\" needs to be a valid file or directory.""$normal" && return 1

    set +m
    while true; do
        inotifywait --recursive -qq -e modify "$1"
        clear
        echo -n "${green}Running ""$blue"\'"${@:2}"\'"$green" "on $1 (""$(now)) ""$normal"
        "${@:2}" >/tmp/out.log 2>&1 &
        pid=$!
        start=$(date +%s.%N)
        spinner "$pid"
        if [[ $? -eq 0 ]]; then
            echo "$green[OK]""$normal"
            echo -ne "\033]30;[OK] $(now) \007"
        else
            echo "$red[ERROR]""$normal"
            echo -ne "\033]30;[ERROR] $(now) \007"
        fi
        end=$(date +%s.%N)

        echo
        command cat /tmp/out.log
        echo
        echo -n "Took" "$green"
        echo "scale=4; ($end - $start)" | bc | xargs printf "%.3f"
        echo "s""$normal to complete."

        sleep 0.5
    done
    set -m
}

function replace() {
    from="$1"
    to="$2"

    rg "$from" | rep "$from" "$to"
}

function aws-login() {
    TOKENS=$(aws-mfa "$1")
    read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<<"$TOKENS"
    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    echo "AWS tokens exported to ENV"
}

function flash_loc_rug {
    cd ~/Projects/RUG2-buildroot/
    for arg in "$@"; do
        make TARGET=rug2_production "$arg"-dirclean "$arg"
        make TARGET=rug2_production
    done
}

function hex() {
    python -c "print(hex($1))"
}

function dec() {
    python -c "print(int('$1', 16))"
}

function donotify() {
    start=$(date +%s)
    "$@" && notify-send --urgency="critical" "Notification: DONE" "\"$(echo "$@")\" took $(($(date +%s) - start)) seconds to finish" || notify-send --urgency="critical" "Notification: ERROR" "\"$(echo "$@")\" failed after $(($(date +%s) - start)) seconds"
}

function stringiest() {
    set +m
    max="${1:-25}"
    find . -type f | xargs -I {} sh -c "strings '{}'|wc -l|tr -d '\n' && echo ': {}'" | sort --numeric-sort | tail -"$max" &
    spinner $!
    set -m
}

function copy() {
    cat "$1" | xclip -selection secondary
}

function rugssh_legacy() {
    if [ "$1" = "" ]; then
        target="root@10.0.1.251"
    elif [[ $1 =~ "@" ]]; then
        target="$1"
    else
        target="root@10.42.0.${1}"
    fi
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa_railster "$target"
}

function rugssh() {
    if [ "$1" = "" ]; then
        target="root@10.0.1.251"
    elif [[ $1 =~ "@" ]]; then
        target="$1"
    else
        target="root@10.42.0.${1}"
    fi
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa_railster2 "$target"
}

function rugcmd() {
    target="root@10.0.1.251"
    command_to_run="$@"

    ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa_railster "$target" "$command_to_run"
}

function rugclean() {
    make -C ~/Projects/RUG2-buildroot/ -s TARGET=rug2_production clean || (
        notify-send --urgency="critical" "RUG2-buildroot" "Failed to clean"
        return 1
    )
    make -C ~/Projects/RUG2-buildroot/ -s TARGET=rug2_production defconfig || (
        notify-send --urgency="critical" "RUG2-buildroot" "Failed to defconfig"
        return 1
    )
    notify-send --urgency="critical" "RUG2-buildroot" "Cleaned successfully"
    return 0
}

function rugbuild() {
    if [ "$1" = "" ]; then
        target=""
    else
        target="$1-dirclean $1"
    fi

    {
        cd ~/Projects/RUG2-buildroot/
        if [ "$target" = "" ]; then
            ./build-with-docker TARGET=rug2_production "${target}-dirclean" "$target"
        else
            ./build-with-docker TARGET=rug2_production
        fi
        make -C ~/Projects/RUG2-buildroot/ -s TARGET=rug2_production "${target}-dirclean" "$target"
        if [ $? != 0 ]; then
            notify-send --urgency="critical" "RUG2-buildroot" "Failed to build $1"
            return 1
        fi
    }

    # make -C ~/Projects/RUG2-buildroot/ -s TARGET=rug2_production
    # if [ $? != 0 ]; then
    #     notify-send --urgency="critical" "RUG2-buildroot" "Failed to build $1"
    #     return 1
    # fi

    notify-send --urgency="critical" "RUG2-buildroot" "Built successfully $1"
    return 0
}

function rugbuildall() {
    if [ "$1" = "" ]; then
        target=""
    else
        target="$1-dirclean $1"
    fi

    make -C ~/Projects/RUG2-buildroot/ -s TARGET=rug2_production
    if [ $? != 0 ]; then
        notify-send --urgency="critical" "RUG2-buildroot" "Failed to build $1"
        return 1
    fi

    notify-send --urgency="critical" "RUG2-buildroot" "Built successfully $1"
    return 0
}

function run_python() {
    if [ "$1" != "" ]; then
        python "$@"
    else
        bpython
    fi
}

function jqdiff() {
    diff <(jq --sort-keys . "$1") <(jq --sort-keys . "$2")
}

function find_strings() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <directory> <pattern>"
        exit 1
    fi

    search_dir=$1
    search_pattern=$2

    find "$search_dir" -type f -exec grep -aHo "$search_pattern" {} \; |
        awk -F: '{
            count[$1]++
        } END {
            max_count_length = 0
            for (file in count) {
                if (length(count[file]) > max_count_length) {
                    max_count_length = length(count[file])
                }
            }
            for (file in count) {
                printf "%-"max_count_length"d %s\n", count[file], file
            }
        }' | sort --numeric-sort
}

function rugsync() {
    path_from="$1"
    path_to="root@10.0.1.251:/mnt/fsuser-1/"
    set +m

    if [ "$path_from" = "" ]; then
        echo "Source directory must be specified"
        return 1
    fi

    while true; do
        modified_file=$(inotifywait --recursive --format '%w%f' -q -e modify "$path_from" | head -n 1)
        echo "$modified_file" " -> " "$path_to"

        notify-send "Syncing modified file ${modified_file} to ${path_to}" -t 1000
        rsync -e 'ssh -i ~/.ssh/id_rsa_railster2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --progress "$modified_file" "$path_to"

        if [ $? -eq 0 ]; then
            notify-send "Sync OK" -t 1000
        else
            notify-send "Sync ERROR" -t 1000
        fi
    done
    set -m
}

# function rugsync() {
#     path_from="$1"
#     path_to="root@10.0.1.251:/mnt/fsuser-1/"
#     set +m
#     while true; do
#         inotifywait --recursive -qq -e modify "$1"
#         notify-send "syncing ${path_from} to ${path_to}" -t 1000
#         rsync -r -e 'ssh -i ~/.ssh/id_rsa_railster2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --progress "$path_from" "$path_to"
#         if [ $? -eq 0 ]; then
#             notify-send "OK" -t 1000
#         else
#             notify-send "ERROR" -t 1000
#         fi
#     done
#     set -m
# }

rugrsync() {
    if [ "$#" -eq 1 ]; then
        rsync -r -e 'ssh -i ~/.ssh/id_rsa_railster2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --progress "$1" "root@10.0.1.251:/mnt/fsuser-1"
    else
        rsync -r -e 'ssh -i ~/.ssh/id_rsa_railster2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --progress "$@"
    fi
}

# function rugrsync() {
#   local src=$1
#   local dest=$2
#
#    [[ -z "$dest" ]] && dest="root@10.0.1.251:/mnt/fsuser-1"
#   if [[ ! "$src" =~ ^root@10.0.1.251: ]] && [[ ! "$dest" =~ ^root@10.0.1.251: ]]; then
#     dest="root@10.0.1.251:${dest}"
#   fi
#
#   echo src: $src
#   echo dest: $dest
#
#   rsync -r -e 'ssh -i ~/.ssh/id_rsa_railster2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --progress "$src" "$dest"
# }
