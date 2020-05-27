# bash

REPO_DIR="${REPO_DIR:-$(cd $(dirname $BASH_SOURCE)/.. && pwd)}"
DOTS_ROOT="${DOTS_ROOT:-$HOME/.dotfiles}"

CUSTOM_RC_DIR=""
case "$SHELL" in
  */bash )
    CUSTOM_RC_DIR="${HOME}/.bashrc.d" ;;
  */zsh )
    CUSTOM_RC_DIR="${HOME}/.zshrc.d" ;;
  * )
    ;;
esac

# symlink
LINKER="$REPO_DIR/submodule/bash-links/links --verbose"
if [[ ${LINKS_FORCE:-} ]]; then
  LINKER="${LINKER} --force"
fi

link_dots_root() {
  $LINKER $REPO_DIR $DOTS_ROOT
}

mk_custom_rc_dir() {
  if [[ "$CUSTOM_RC_DIR" ]]; then
    mkdir -p $CUSTOM_RC_DIR
    echo "[ok] mkdir $CUSTOM_RC_DIR"
  fi
}

bootstrap() {
  link_dots_root
  mk_custom_rc_dir
}

symlink() {
  local src="${DOTS_ROOT}/${1}";
  local link="${HOME}/$1"
  local _dir="${1%/*}"
  if [[ "$_dir" != "$1" ]]; then
    mkdir -p "$HOME/${_dir}"
    echo "[ok] mkdir $HOME/${_dir}"
  fi
  $LINKER $src $link
}

symlink2() {
  local src=$DOTS_ROOT/$1
  local link=$2
  $LINKER $src $link
}
