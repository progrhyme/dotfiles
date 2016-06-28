if which peco >& /dev/null; then
  # unbind for peco
  bind -r "\C-u"

  # for dir change
  PECO_CD_CMD=${PECO_CD_CMD:-pushd}

  # search pid
  SELECTOR=peco
  _insert_pid() {
    local psopt
    if [[ $(id -u) = "0" ]]; then
      psopt='axwww'
    else
      psopt='xwww'
    fi
    local l=$(ps $psopt -o user,pid,cmd | $SELECTOR | awk '{print $2}' | tr '\n' ' ')
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${l}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + ${#l}))
  }
  bind -x '"\C-up": _insert_pid'

  # search history
  peco-select-history() {
    local tac
    if which tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    local l=$(HISTTIMEFORMAT="" \history | awk '{$1="";print}' | eval $tac | peco | cut -d' ' -f2-)
    READLINE_LINE="${l}"
    READLINE_POINT=${#l}
  }
  bind -x '"\C-r": peco-select-history'

  # search repo dirs
  if [[ -z $__PECO_SRCH_REPOS ]]; then
    __PECO_SRCH_REPOS=($HOME/gitrepos $HOME/my/repos $HOME/my/go/src)
  fi
  peco-cd-repodir() {
    local _dirs repo
    for repo in ${__PECO_SRCH_REPOS[@]}; do
      if [[ -d $repo ]]; then
        _dirs+=( $(\find ${repo} -type d -a \! -regex '.*\.git.*') )
      fi
    done
    local _dir=$(echo ${_dirs[@]} | tr ' ' '\n' | peco)
    $PECO_CD_CMD $_dir > /dev/null
  }
  peco-find-repository() {
    local _files repo
    for repo in ${__PECO_SRCH_REPOS[@]}; do
      if [[ -d $repo ]]; then
        _files+=( $(\find ${repo} \! -regex '.*\.git.*') )
      fi
    done
    local l=$(for _f in ${_files[@]}; do echo $_f; done | peco)
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${l}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + ${#l}))
  }
  bind -x '"\C-ud": peco-cd-repodir'
  bind -x '"\C-uf": peco-find-repository'

  # search current directory
  peco-find() {
    local l=$(\find . -maxdepth 8 -a \! -regex '.*/\..*' | peco)
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${l}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + ${#l}))
  }
  function peco-find-all() {
    local l=$(\find . -maxdepth 8 | peco)
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${l}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + ${#l}))
  }
  bind -x '"\C-uc": peco-find'
  bind -x '"\C-ua": peco-find-all'
fi
