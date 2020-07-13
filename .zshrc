# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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


# ZSH_THEME=bullet-train
# ZSH_THEME=powerlevel10k/powerlevel10k
# ZSH_THEME="bullet-train"

# BULLETTRAIN_PROMPT_ORDER=(
#     time
#     cmd_exec_time
#     git
#     # context
#     dir
#     status
#     virtualenv
# )
# BULLETTRAIN_PROMPT_CHAR="☼"
# BULLETTRAIN_PROMPT_CHAR="↪"
# BULLETTRAIN_PROMPT_CHAR="😸"
# BULLETTRAIN_PROMPT_CHAR="😃"

# PURE
ZSH_THEME=""



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

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git extract)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh


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
function search() {
    if [[ $# -eq 1 ]]
    then
        pattern=$1
        grep -rnoP ".{0,30}$pattern.{0,30}" *
        return $?
    elif [[ $# -eq 2 ]]
    then
        extension=$1
        pattern=$2
        grep -rnoP ".{0,30}${pattern}.{0,30}" **/*.$extension 
        return $?
    elif [[ $# -eq 3 ]]
    then
        extension=$1
        context=$2
        pattern=$3
        grep -rnoP ".{0,$context}${pattern}.{0,$context}" **/*.$extension 
        return $?
    fi

    echo $fg[yellow]"Usage: search [extension] [context] <pattern>"
    return 1
}

function search2() {
    case $# in
        1)
            pattern=$1
            context=30
            match="*"
            ;;
        2)
            pattern=$2
            context=30
            match="**/*.$1"
            ;;
        3)
            pattern=$3
            context=$2
            match="**/*.$1"
            ;;
        *)
            echo $fg[yellow]"Usage: search [extension [context]] <pattern>"
            return 1
            ;;
    esac

    grep -rnoP ".{0,$context}${pattern}.{0,$context}" $match
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
prompt pure
