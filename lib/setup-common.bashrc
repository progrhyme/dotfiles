# bash

REPO_DIR="${REPO_DIR:-$(cd $(dirname $BASH_SOURCE)/.. && pwd)}"
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

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
LINKER="$DOTFILES/submodule/bash-links/links --verbose"
if [[ ${LINKS_FORCE:-} ]]; then
  LINKER="${LINKER} --force"
fi

init_base_dir() {
  $LINKER $REPO_DIR $DOTFILES
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

symlink() {
  local src="${DOTFILES}/${1}";
  local link="${HOME}/$1"
  local _dir="${1%/*}"
  if [[ "$_dir" != "$1" ]]; then
    mkdir -p "$HOME/${_dir}"
    echo "[ok] mkdir $HOME/${_dir}"
  fi
  $LINKER $src $link
}

symlink2() {
  local src=$DOTFILES/$1
  local link=$2
  $LINKER $src $link
}
