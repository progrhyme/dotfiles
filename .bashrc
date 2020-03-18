# .bashrc

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

PS1="\[\e[0;32m\]\u@\h:\w$\[\e[0m\] "

export PATH=.:$PATH

# aliases
if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
alias ll='ls -l'
alias lla='ls -al'

# extentional settings
if [ -d ${HOME}/.bashrc.d ]; then
  for file in `find ${HOME}/.bashrc.d -mindepth 1`; do
    source $file
  done
fi

HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
