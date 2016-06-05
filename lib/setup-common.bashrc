BASE_DIR=$HOME/dotfiles
REPOS_DIR=$HOME/gitrepos/dotfiles
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
  if [[ -e $BASE_DIR ]]; then
    echo "[info] ${BASE_DIR} exists"
  else
    ln -s $REPOS_DIR $BASE_DIR
    echo "[ok] linked. $BASE_DIR -> $REPOS_DIR"
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
LINKER="$BASE_DIR/submodule/bash-links/links --verbose"
if [[ ${LINKS_FORCE:-} ]]; then
  LINKER="${LINKER} --force"
fi

symlink() {
  local src="${BASE_DIR}/${1}";
  local link="${HOME}/$1"
  $LINKER $src $link
}

symlink2() {
  local src=$BASE_DIR/$1
  local link=$2
  $LINKER $src $link
}
