# bash
REPO_DIR=${REPO_DIR:-$HOME/my/repos/dotfiles}
DOTS_DIR=${DOTS_DIR:-$HOME/dotfiles}
CUSTOM_RC_DIR=""
case "$SHELL" in
  */bash )
    CUSTOM_RC_DIR="${HOME}/.bashrc.d" ;;
  */zsh )
    CUSTOM_RC_DIR="${HOME}/.zshrc.d" ;;
  * )
    ;;
esac

init_base_dir() {
  if [[ -e $DOTS_DIR ]]; then
    echo "[info] ${DOTS_DIR} exists"
  else
    ln -s $REPO_DIR $DOTS_DIR
    echo "[ok] linked. $DOTS_DIR -> $REPO_DIR"
  fi
}

mk_custom_rc_dir() {
  if [[ "$CUSTOM_RC_DIR" ]]; then
    mkdir -p $CUSTOM_RC_DIR
    echo "[ok] mkdir $CUSTOM_RC_DIR"
  fi
}

init() {
  init_base_dir
  mk_custom_rc_dir
}

# symlink
LINKER="$DOTS_DIR/submodule/bash-links/links --verbose"
if [[ ${LINKS_FORCE:-} ]]; then
  LINKER="${LINKER} --force"
fi

symlink() {
  local src="${DOTS_DIR}/${1}";
  local link="${HOME}/$1"
  $LINKER $src $link
}

symlink2() {
  local src=$DOTS_DIR/$1
  local link=$2
  $LINKER $src $link
}
