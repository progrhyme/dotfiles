HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

autoload -U colors
colors

autoload -U compinit
compinit

setopt auto_cd    # cd to directory with directory path only
setopt auto_pushd # pushd when cd
setopt correct    # correct misspell
setopt auto_list  # list complementary items
setopt extended_history # record executed time to history

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias ls='ls --show-control-chars --color=auto'
alias ll='ls -l'
alias la='ls -a'
