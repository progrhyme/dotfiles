# bash

REPO_DIR="${REPO_DIR:-$(cd $(dirname $BASH_SOURCE)/.. && pwd)}"
DOTS_ROOT="${DOTS_ROOT:-$HOME/.dotfiles}"
DOTSH_DIR="${DOTSH_DIR:-${REPO_DIR}/submodule/dot-sh}"
source "${DOTSH_DIR}/dot.sh"

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
LINKER="${REPO_DIR}/submodule/bash-links/links --verbose"
if [[ -n "${LINKS_FORCE:-}" ]]; then
  LINKER="${LINKER} --force"
fi

mkdir_p() {
  if [[ -d "$1" ]]; then
    echo "[ok] Directory $1 already exists"
  elif [[ -e "$1" ]]; then
    echo "[error] Can't create directory! File exists at $1"
    return 1
  else
    mkdir -p "$1"
    echo "[ok] mkdir $1"
  fi
}

link_dots_root() {
  $LINKER $REPO_DIR $DOTS_ROOT
}

mk_custom_rc_dir() {
  if [[ "$CUSTOM_RC_DIR" ]]; then
    mkdir_p $CUSTOM_RC_DIR
  fi
}

bootstrap() {
  link_dots_root
  mkdir_p "${HOME}/bin"
  mkdir_p "${HOME}/.init.d"
  mk_custom_rc_dir
}

# Create symlink to $1 at $HOME/$1
# Use route() by dot.sh
chain_home() {
  local src="$(route "$1" || true)"
  if [[ -z "$src" ]]; then
    echo "[error] $1 doesn't exist!"
    return 1
  fi
  local link="${HOME}/$1"
  local _dir="${1%/*}"
  if [[ "$_dir" != "$1" ]]; then
    mkdir_p "$HOME/${_dir}"
  fi
  $LINKER $src $link
}

# Create symlink to $1 at $2
# Use route() by dot.sh
chain() {
  local src="$(route "$1" || true)"
  if [[ -z "$src" ]]; then
    echo "[error] $1 doesn't exist!"
    return 1
  fi
  local link=$2
  local _dir="${2%/*}"
  if [[ ! -d "${_dir}" ]]; then
    mkdir -p "${_dir}"
    echo "[ok] mkdir ${_dir}"
  fi
  $LINKER $src $link
}
