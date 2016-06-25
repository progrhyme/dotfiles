GIT_COMPLETION_FILE=${GIT_COMPLETION_FILE:-"$HOME/.git-completion.bash"}

if [ -f "$GIT_COMPLETION_FILE" ]; then
  . $GIT_COMPLETION_FILE
  GIT_PS1_SHOWDIRTYSTATE=1
  __base_ps1=${__base_ps1:-$PS1}
  PS1="\[\e[0;35m\]\$(__git_ps1 '(%s) ')\[\e[0m\]${__base_ps1}"
fi

unset GIT_COMPLETION_FILE

