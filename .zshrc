# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.cargo/bin
export VISUAL=nvim;
export EDITOR=nvim;

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh

setopt NULL_GLOB

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="typewritten"
# export TYPEWRITTEN_CURSOR="beam"
# export TYPEWRITTEN_MULTILINE=true


ZSH_THEME=bullet-train
# ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="powerlevel10k/powerlevel10k"

BULLETTRAIN_PROMPT_ORDER=(
    time
    cmd_exec_time
    git
    # context
    dir
    status
    virtualenv
)
# BULLETTRAIN_PROMPT_CHAR="☼"
BULLETTRAIN_PROMPT_CHAR="↪"
# BULLETTRAIN_PROMPT_CHAR="😸"
# BULLETTRAIN_PROMPT_CHAR="😃"

# PURE
# ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git extract)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

red=$(tput bold;tput setaf 1)
green=$(tput bold;tput setaf 2)
normal=$(tput sgr0)

function imhere() {
    while true
    do
        xdotool mousemove_relative --sync 1 0 2&> /dev/null
        sleep 1
        xdotool mousemove_relative --sync -- -1 0 2&> /dev/null
        sleep 1
    done
}

export EDITOR='nvim'
# function search() {
#     if [[ $# -eq 1 ]]
#     then
#         pattern=$1
#         grep -rnoP ".{0,30}$pattern.{0,30}" *
#         return $?
#     elif [[ $# -eq 2 ]]
#     then
#         extension=$1
#         pattern=$2
#         grep -rnoP ".{0,30}${pattern}.{0,30}" **/*.$extension 
#         return $?
#     elif [[ $# -eq 3 ]]
#     then
#         extension=$1
#         context=$2
#         pattern=$3
#         grep -rnoP ".{0,$context}${pattern}.{0,$context}" **/*.$extension 
#         return $?
#     fi

#     echo $fg[yellow]"Usage: search [extension] [context] <pattern>"
#     return 1
# }

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
    sleep 0.5
}

function spinner() {
  # make sure we use non-unicode character type locale 
  # (that way it works for any locale as long as the font supports the characters)
  local LC_CTYPE=C

  local pid=$1 # Process Id of the previous running command
  local choice=8

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
    date -u +"%H:%M:%S"
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

    set +m
    while true; do
         inotifywait -e modify "$1" 2>/dev/null
         echo -n ${green}"Making $1 ("$(now)") "${normal}
         make > /tmp/log.log 2>&1 &
         spinner $!
         if [[ $? -eq 0 ]]; then
             echo ${green}"[OK]"${normal}
             echo -ne "\033]30;[OK] $(now) \007"
         else
            echo ${red}"[ERROR]"${normal}
            echo -ne "\033]30;[ERROR] $(now) \007"
            cat /tmp/log.log
            rm /tmp/log.log
         fi
         sleep 0.5
    done
    set +m
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


alias oldvim="/usr/bin/vim"
alias vim="nvim"
alias lss='command ls --color --group-directories-first -ldf [^_]* [_]*'
# alias ls='ls --color --group-directories-first --icon-theme fancy'
alias ls='lsd --icon=auto --group-dirs first --icon-theme fancy'
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias oldexit="exit"
alias exit='goodbye ; oldexit'


# source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# eval `dircolors ~/.dir_colors/dircolors.256dark`
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U compinit && compinit

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

autoload -U promptinit; promptinit
# prompt pure

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
