if which peco >/dev/null 2>&1 && [[ -t 1 ]]; then
  # unbind for peco
  bindkey -r '^u'

  # search history
  function peco-select-history() {
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
  function peco-cd-repodir() {
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
  function peco-find-repository() {
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
  function peco-find() {
    local l=$(\find . -maxdepth 8 -a \! -regex '.*/\..*' | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  function peco-find-all() {
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
  function peco-cdr() {
    local _dir=$(cdr -l | awk '{ print $2 }' | peco)
    BUFFER="cd ${_dir}"
    zle accept-line
    zle clear-screen
  }
  zle -N peco-cdr
  bindkey '^ur' peco-cdr
fi
