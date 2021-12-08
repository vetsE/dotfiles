source ~/.config/zsh/colors.zsh

function imhere() {
    while true
    do
        xdotool mousemove_relative --sync 1 0 2&> /dev/null
        sleep 1
        xdotool mousemove_relative --sync -- -1 0 2&> /dev/null
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
            echo $fg[yellow]"Usage: search [extension [context]] <pattern>"
            return 1
            ;;
    esac

    grep --color=always -rnoEI ".{0,$context}${pattern}.{0,$context}" $match
    return $?
}

function search_file() {
    if [[ $# -eq 1 ]]
    then
        pattern=$1
        find -name "*$1*"
        return $?
    fi
    echo $fg[yellow]"Usage: search_file <pattern>"
    return 1
}

function copy_from_server() {
    if [[ $# -eq 2 ]]
    then
        source=$1
        destination=$2
        rsync -aHAXx --progress --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" pereat:/home/deleo/$source $destination
        # rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" pereat:/home/deleo/$source $destination
        return $?
    fi

    echo $fg[yellow]"Usage: copy_from_server <source> <destination>"
    return 1
}

function goodbye() {
    color=$(tput bold;tput setaf 7) 
    normal=$(tput sgr0)
    echo "${color}See You Space Cowboy...${normal}"
    sleep 0.25
}

function spinner() {
  # make sure we use non-unicode character type locale 
  # (that way it works for any locale as long as the font supports the characters)
  local LC_CTYPE=C

  local pid=$1 # Process Id of the previous running command
  local choice=11

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
  while kill -0 $pid 2>/dev/null; do
    local i=$(((i + $charwidth) % ${#spin}))
    printf "%s" ${green}"${spin:$i:$charwidth}"${normal}
    echo -en "\033]30;${spin:$i:$charwidth}\007"
    echo -en "\033[1D"
    sleep .1
  done
  tput cnorm
  wait $pid
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
    [ ! -d "./tex" ] && echo ${red}"Couldn't find a 'tex' directory."${normal} && return 1

    while true; do
         inotifywait -e modify "./tex" 2>/dev/null
         echo -n ${green}"Making "$(basename $(pwd))" ("$(now)") "${normal}
         make > /tmp/wam.log 2>&1 &
         spinner $!
         if [[ $? -eq 0 ]]; then
             echo ${green}"[OK]"${normal}
             echo -ne "\033]30;[OK] $(now) \007"
         else
            echo ${red}"[ERROR]"${normal}
            echo -ne "\033]30;[ERROR] $(now) \007"
            cat /tmp/wam.log | grep "^l\.[0-9]\+"
            rm /tmp/wam.log
         fi
         sleep 0.5
    done
    set -m
}

function watch_and_make() {

    [ ! $# -eq 1 ] && echo ${red}"Need a file to watch."${normal} && return 1

    watch_and_do "$1" "make"
}

function watch_and_run() {
    [ ! $# -eq 1 ] && echo "Usage: '${green}watch_and_run <file>'"${normal}"." && return 1
    [[ ! -f $1 ]] && echo ${red}"\"$1\" needs to be a valid file."${normal} && return 1

    ext="${1##*.}"
    case "$ext" in
        "py")
            watch_and_do $1 python $1
            ;;
        *)
            echo "${red}Doesn't know how to run this extension: $ext"
            return 1
            ;;
    esac

}

function watch_and_do() {

    [[ ! -f $1 || -d $1 ]] && echo ${red}"\"$1\" needs to be a valid file or directory."${normal} && return 1

    set +m
    while true; do
        inotifywait -qq -e modify "$1"
        clear
        echo -n ${green}"Running "${blue}\'${@:2}\'${green} "on $1 ("$(now)") "${normal}
        ${@:2} > /tmp/out.log 2>&1 &
        pid=$!
        start=$(date +%s.%N)
        spinner $pid
        if [[ $? -eq 0 ]]; then
            echo ${green}"[OK]"${normal}
            echo -ne "\033]30;[OK] $(now) \007"
        else
           echo ${red}"[ERROR]"${normal}
           echo -ne "\033]30;[ERROR] $(now) \007"
        fi
        end=$(date +%s.%N)

        echo
        bat --style=numbers,rule --theme=Solarized\ \(dark\)  /tmp/out.log
        echo
        echo -n "Took" ${green}
        echo "scale=4; ($end - $start)" | bc | xargs printf "%.3f"
        echo "s"${normal}" to complete."

        sleep 0.5
    done
    set -m
}

function replace() {
    context=20

    if [[ $# -eq 2 ]]
    then
        from="$1"
        to="$2"
        cmd="find . -type f | xargs sed -i \"s/\\\b${from}\\\b/${to}/g\""
        greped=$(grep -roIP ".{0,${context}}${from}.{0,${context}}" *)
        conflict=$(grep -roIP ".{0,${context}}${to}.{0,${context}}" *)
    elif [[ $# -eq 3 ]]
    then
        extension="$1"
        from="$2"
        to="$3"
        cmd="find . -type f -name \"*.$extension\" | xargs sed -i \"s/\\\b${from}\\\b/${to}/g\""
        greped=$(grep -roIP ".{0,${context}}${from}.{0,${context}}" **/*.${extension})
        conflict=$(grep -roIP ".{0,${context}}${to}.{0,${context}}" **/*.${extension})
    else
        echo $fg[yellow]"Usage: replace [extension] <from> <to>"
        return 1
    fi

    red=$(tput bold;tput setaf 1)
    green=$(tput bold;tput setaf 2)
    normal=$(tput sgr0)

    size_first=$(echo $greped | cut -d':' -f1 | awk '{ print length, $0 }' | sort -n -s | tail -n 1 | cut -d' ' -f1)
    size_second=$(( ${#from} + ${context} * 2 + 10 ))

    IFS=$'\n'
    for line in $(echo $greped)
    do
        first=$(echo $line | cut -d':' -f1)
        rest=$(echo $line | cut -d':' -f2-)
        second=$(echo $rest | sed -e "s/\b${from}\b/${green}${from}${normal}/g" -e 's/^ *//g')
        third=$(echo $rest | sed -e "s/\b${from}\b/${red}${to}${normal}/g" -e 's/^ *//g')
        # third=$(echo $rest | sed "s/\b${from}\b/${red}${to}${normal}/g")
        printf "%-${size_first}s  |  %-${size_second}s  |  %-s\n" $first $second $third
    done

    if [ ! -z $conflict ]
    then
        echo 
        echo "${red}WARNING: Apply theses changes could overwrite preexisting tokens!${normal}"
        echo "${red}WARNING: Apply theses changes could overwrite preexisting tokens!${normal}"
        echo 
        echo "${red}Preexisting: ${normal}"
        echo "${red}-------------${normal}"
        echo "${red}${conflict} ${normal}"
        echo 
        echo "${red}WARNING: Apply theses changes could overwrite preexisting tokens!${normal}"
        echo "${red}WARNING: Apply theses changes could overwrite preexisting tokens!${normal}"
    fi
    echo 
    echo "${red}Apply changes with: ${normal}"
    echo 
    echo $cmd
}

function aws-login() {
    TOKENS=$(aws-mfa $1)
    read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< ${TOKENS}
    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    echo "AWS tokens exported to ENV"
}
