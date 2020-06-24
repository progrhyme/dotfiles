if which peco >& /dev/null && [[ -t 1 ]]; then
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
  __PECO_SRCH_REPOS_MAXDEPTH=${__PECO_SRCH_REPOS_MAXDEPTH:-5}
  peco-cd-repodir() {
    local _dirs repo
    for repo in ${__PECO_SRCH_REPOS[@]}; do
      if [[ -d $repo ]]; then
        _dirs+=(
          $(\find ${repo} -maxdepth ${__PECO_SRCH_REPOS_MAXDEPTH} \
            -type d -a \! -regex '.*\/\(.git\|submodule\|node_modules\).*')
        )
      fi
    done
    local _dir=$(echo ${_dirs[@]} | tr ' ' '\n' | peco)
    $PECO_CD_CMD $_dir > /dev/null
  }
  peco-find-repository() {
    local _files repo
    for repo in ${__PECO_SRCH_REPOS[@]}; do
      if [[ -d $repo ]]; then
        _files+=(
          $(\find ${repo} -maxdepth ${__PECO_SRCH_REPOS_MAXDEPTH} \
              \! -regex '.*\/\(.git\|submodule\|node_modules\)/.*')
        )
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
  peco-find-all() {
    local l=$(\find . -maxdepth 8 | peco)
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${l}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + ${#l}))
  }
  bind -x '"\C-uc": peco-find'
  bind -x '"\C-ua": peco-find-all'

  # Switch kubectl context/namespace
  if command -v kubectl &>/dev/null; then
    peco-kubectx() {
      local l=$(kubectl config get-contexts --no-headers -o=name | peco)
      if [[ -n "$l" ]]; then
        kubectl config use-context $l
      fi
    }
    peco-kubens() {
      local l=$(kubectl get namespaces --no-headers --output "custom-columns=NAME:.metadata.name" | peco)
      if [[ -n "$l" ]]; then
        kubectl config set-context $(kubectl config current-context) --namespace=$l
      fi
    }
    bind -x '"\C-ux": peco-kubectx'
    bind -x '"\C-un": peco-kubens'
  fi

  # Switch gcloud configuration
  if command -v gcloud &>/dev/null; then
    peco-gcloud-configuration() {
      local l=$(gcloud config configurations list --format='value(name)' | peco)
      if [[ -n "$l" ]]; then
        gcloud config configurations activate $l
      fi
    }
    bind -x '"\C-ug": peco-gcloud-configuration'
  fi
fi
