if which peco >/dev/null 2>&1 && [[ -t 1 ]]; then
  # unbind for peco
  bindkey -r '^u'

  # search history
  peco-select-history() {
    local tac
    if which tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | eval $tac | peco)
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  # search repo dirs
  if [[ -z $__PECO_SRCH_REPOS ]]; then
    __PECO_SRCH_REPOS=($HOME/gitrepos $HOME/my/repos $HOME/my/go/src)
  fi
  __PECO_SRCH_REPOS_MAXDEPTH=${__PECO_SRCH_REPOS_MAXDEPTH:-5}
  peco-cd-repodir() {
    local _dirs repo
    for repo in ${__PECO_SRCH_REPOS[@]}; do
      if [[ -d $repo ]]; then
        _dirs+=(
          $(\find ${repo} -maxdepth ${__PECO_SRCH_REPOS_MAXDEPTH} -type d -a \! -regex '.*\.git.*')
        )
      fi
    done
    local _dir=$(for _d in ${_dirs[@]}; do echo $_d; done | peco)
    pushd $_dir > /dev/null
    zle clear-screen
  }
  peco-find-repository() {
    local _files repo
    for repo in ${__PECO_SRCH_REPOS[@]}; do
      if [[ -d $repo ]]; then
        _files+=( $(\find ${repo} -maxdepth ${__PECO_SRCH_REPOS_MAXDEPTH} \! -regex '.*\.git.*') )
      fi
    done
    local l=$(for _f in ${_files[@]}; do echo $_f; done | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-cd-repodir
  zle -N peco-find-repository
  bindkey '^ud' peco-cd-repodir
  bindkey '^uf' peco-find-repository

  # search current directory
  peco-find() {
    local l=$(\find . -maxdepth 8 -a \! -regex '.*/\..*' | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  peco-find-all() {
    local l=$(\find . -maxdepth 8 | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-find
  zle -N peco-find-all
  bindkey '^uc' peco-find
  bindkey '^ua' peco-find-all

  # search cdr history
  peco-cdr() {
    local _dir=$(cdr -l | awk '{ print $2 }' | peco)
    BUFFER="cd ${_dir}"
    zle accept-line
    zle clear-screen
  }
  zle -N peco-cdr
  bindkey '^ur' peco-cdr

  # Switch kubectl context/namespace
  if command -v kubectl &>/dev/null; then
    peco-kubectx() {
      local l=$(kubectl config get-contexts --no-headers -o=name | peco)
      if [[ -n "$l" ]]; then
        BUFFER="kubectl config use-context $l"
        zle accept-line
      fi
    }
    peco-kubens() {
      local l=$(kubectl get namespaces --no-headers --output "custom-columns=NAME:.metadata.name" | peco)
      if [[ -n "$l" ]]; then
        BUFFER="kubectl config set-context $(kubectl config current-context) --namespace=$l"
        zle accept-line
      fi
    }
    zle -N peco-kubectx
    zle -N peco-kubens
    bindkey '^ux' peco-kubectx
    bindkey '^un' peco-kubens
  fi
fi
