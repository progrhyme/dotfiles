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

## prompt
setopt prompt_subst

tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

PROMPT=$tmp_prompt
PROMPT2=$tmp_prompt2
RPROMPT=$tmp_rprompt
SPROMPT=$tmp_sprompt

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

## aliases
alias ls='ls --show-control-chars --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'

if [ -d .zshrc.d ]; then
  for file in `find .zshrc.d -mindepth 1`; do
    source $file
  done
fi

# plenv
eval "$(plenv init -)"
