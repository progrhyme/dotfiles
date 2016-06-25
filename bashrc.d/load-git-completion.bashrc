GIT_COMPLETION_FILE=${GIT_COMPLETION_FILE:-"$HOME/.git-completion.bash"}

__custom_ps1() {
  local branch=$(__git_ps1)
  __base_ps1=${__base_ps1:-$PS1}
  [[ $branch ]] && branch="\[\e[0;35m\]$branch\[\e[0m\] "
  echo "${branch}${__base_ps1}"
}

if [ -f "$GIT_COMPLETION_FILE" ]; then
  . $GIT_COMPLETION_FILE
  PS1=$(__custom_ps1)
else
  return
fi

unset GIT_COMPLETION_FILE

