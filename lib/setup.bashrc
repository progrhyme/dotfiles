# bash
#
# Assume dot-sh/dot.sh is loaded beforehand
REPO_DIR="${REPO_DIR:-$(cd $(dirname $BASH_SOURCE)/.. && pwd)}"
dots_root="$HOME/.dotfiles"

CUSTOM_RC_DIR=""
case "$SHELL" in
  */bash )
    CUSTOM_RC_DIR="${HOME}/.bashrc.d" ;;
  */zsh )
    CUSTOM_RC_DIR="${HOME}/.zshrc.d" ;;
  * )
    ;;
esac

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
  $DOT_LINK_CMD $REPO_DIR $dots_root
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
