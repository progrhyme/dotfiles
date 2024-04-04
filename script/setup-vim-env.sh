#!/usr/bin/env bash

set -euo pipefail

eval "$(shelp init -)"

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
DOTS_ROOT=${DOTS_ROOT:-"$(cd $(dirname $0)/.. && pwd)"}
include dot-sh dot.sh
require lib/setup.bashrc

VIM_DIR=${HOME}/.vim
TARGETS=(.vim/ftplugin .vim/ftdetect .vim/template)

# ============================================================
# Functions

install_vimplug() {
  if [[ -f ${VIM_DIR}/autoload/plug.vim ]]; then
    echo "[OK] Already installed vim-plug"
  else
    curl -fLo ${VIM_DIR}/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

# ============================================================
# Main

if [[ -n "${DOTS_ENV:-}" ]]; then
  echo "##### DOTS_ENV: ${DOTS_ENV} #####"
fi

echo "[START] setup vim environment"

link_dots_root

# create ~/.vim
mkdir -p ${VIM_DIR};

# create symlinks
for t in ${TARGETS[@]}; do
  link_home $t
done

# Install Plugin Manager
install_vimplug

echo "[END] setup vim environment"

exit
