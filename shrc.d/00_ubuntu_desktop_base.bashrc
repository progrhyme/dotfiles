export PATH=.:$PATH

GIT_COMPLETION="$HOME/.git-completion.bash"
if [ -f "$GIT_COMPLETION" ]; then
  source $GIT_COMPLETION
fi

__prompt () {
  local __base_prompt="\e[34m\w\e[0m$ "
  if [ -f "$GIT_COMPLETION" ]; then
    local branch=$(__git_ps1)
    [ -z $branch ] || branch="\[\e[0;35m\]$branch\[\e[0m\]"
    PS1="$branch $__base_prompt"
  else
    PS1=$__base_prompt
  fi
}
PROMPT_COMMAND=__prompt

if which vim >/dev/null 2>&1; then
  alias vi='vim'
fi
