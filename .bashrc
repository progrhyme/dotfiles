# .bashrc

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

PS1="\[\e[0;32m\]\u@\h:\w$\[\e[0m\] "

export PATH=.:$PATH

# extentional settings
if [ -d ${HOME}/.bashrc.d ]; then
  for file in `find ${HOME}/.bashrc.d -mindepth 1`; do
    source $file
  done
fi

HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
