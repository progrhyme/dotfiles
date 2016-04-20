if which peco >& /dev/null; then
  # unbind for peco
  bind -r "\C-u"

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
