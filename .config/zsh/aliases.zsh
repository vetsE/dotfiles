alias oldvim="/usr/bin/vim"
alias vim="nvim"
alias lss='command ls --color --group-directories-first -ldf [^_]* [_]*'
alias ls='eza --color=always --group-directories-first'
alias ll='eza --color=always --group-directories-first -l'
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias oldexit="exit"
alias exit='goodbye ; oldexit'
alias cat='bat --plain'
alias s='search'
alias sf='search_file'
alias rug2pm="picocom -b 115200 /dev/ttyUSB3"
alias rug2term="picocom -b 115200 /dev/ttyUSB2"
# alias rugssh="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa_railster"
alias rugscp="scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
# alias rugrsync="rsync -r -e 'ssh -i ~/.ssh/id_rsa_railster2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --progress"
alias :q="exit"
alias rg="rg -F --binary --no-ignore  --no-ignore-dot --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold"
alias rge="rg --binary --no-ignore  --no-ignore-dot --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold"
alias du="dust"
alias ssh="TERM=xterm-256color ssh"
alias python=run_python
alias fd="fd -I"
alias p="python"
