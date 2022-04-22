alias oldvim="/usr/bin/vim"
alias vim="nvim"
alias lss='command ls --color --group-directories-first -ldf [^_]* [_]*'
alias ls='exa --color=always --group-directories-first'
alias ll='exa --color=always --group-directories-first -l'
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias oldexit="exit"
alias exit='goodbye ; oldexit'
# alias cat='bat'
alias s='search'
alias sf='search_file'
alias rug2pm="picocom -b 115200 /dev/ttyUSB3"
alias rug2term="picocom -b 115200 /dev/ttyUSB2"
alias rugssh="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR root@10.0.1.251"
alias rugscp="scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
alias rg="rg -S"
