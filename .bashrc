# .bashrc

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

PS1="\u@\h:\w> "

export PATH=.:$PATH

GIT_COMPLETION="$HOME/.git-completion.bash"
if [ -f "$GIT_COMPLETION" ]; then
  source $GIT_COMPLETION
fi

__prompt () {
  if [ -f "$GIT_COMPLETION" ]; then
    local branch=$(__git_ps1)
    [ -z $branch ] || branch="\[\e[0;35m\]$branch\[\e[0m\]"
    PS1="$branch \u@\h:\w$ "
  else
    PS1="\u@\h:\w$ "
  fi
}
PROMPT_COMMAND=__prompt

# extentional settings
if [ -d ${HOME}/.bashrc.d ]; then
  for file in `find ${HOME}/.bashrc.d -mindepth 1`; do
    source $file
  done
fi

. ${HOME}/dotfiles/bashrc.d/peco.bashrc

HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
