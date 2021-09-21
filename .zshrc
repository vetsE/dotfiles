export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.cargo/bin
export VISUAL=nvim;
export EDITOR=nvim;

export EDITOR='nvim'

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
antigen apply


source ~/.config/zsh/utils.zsh
source ~/.config/zsh/aliases.zsh
source ~/.fzf.zsh

setopt NULL_GLOB

autoload -U promptinit; promptinit
prompt pure

# autoload -U compinit && compinit
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
# zstyle ':completion:*' accept-exact '*(N)'
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path ~/.zsh/cache

# autoload -U promptinit; promptinit
