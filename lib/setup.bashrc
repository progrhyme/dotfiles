# bash

REPO_DIR="${REPO_DIR:-$(cd $(dirname $BASH_SOURCE)/.. && pwd)}"
DOTS_ROOT="${DOTS_ROOT:-$HOME/.dotfiles}"
THE_ENV_DIR="${THE_ENV_DIR:-}"
if [[ -z "${THE_ENV_DIR}" && -n "${MYENV:-}" && -e "${REPO_DIR}/envs/$MYENV" ]]; then
  THE_ENV_DIR="${REPO_DIR}/envs/$MYENV"
fi

source "${REPO_DIR}/lib/dotenv.shrc"

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
if [[ ${LINKS_FORCE:-} ]]; then
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

symlink() {
  local src="${DOTS_ROOT}/${1}";
  local link="${HOME}/$1"
  local _dir="${1%/*}"
  if [[ "$_dir" != "$1" ]]; then
    mkdir_p "$HOME/${_dir}"
  fi
  $LINKER $src $link
}

symlink2() {
  local src=$DOTS_ROOT/$1
  local link=$2
  $LINKER $src $link
}

# Alternative of symlink()
# Use route() by lib/dotenv.shrc
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

# Alternative of symlink2()
# Use route() by lib/dotenv.shrc
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

# ============================================================
# Set up dotfiles

link_dotfiles() {
  local df
  for df in "${DOT_FILES[@]}"; do
    chain_home $df
  done
}

link_custom_shrc_files() {
  local rc _rc
  for rc in "${CUSTOM_RC_FILES[@]}"; do
    _rc="${rc##*/}"
    chain "$rc" "${CUSTOM_RC_DIR}/${_rc}"
  done
}

setup_dotfiles() {
  link_dotfiles
  link_custom_shrc_files
}

# /Set up dotfiles
# ============================================================
