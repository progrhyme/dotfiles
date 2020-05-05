#!/usr/bin/env bash

set -euo pipefail

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
source "${REPO_DIR}/lib/setup-common.bashrc"

VIM_DIR=${HOME}/.vim
TARGETS=(.vimrc .vim/ftplugin .vim/ftdetect .vim/template)

# ============================================================
# Functions
install_neobundle() {
  local bundle_dir="${VIM_DIR}/bundle"

  if [[ ! -d $bundle_dir ]]; then
    local workrepo="${bundle_dir}/neobundle.vim"
    mkdir -p $bundle_dir
    git clone https://github.com/Shougo/neobundle.vim $workrepo
  fi
}

# ============================================================
# Main
init_base_dir

# create ~/.vim
mkdir -p ${VIM_DIR};

# create symlinks
for t in ${TARGETS[@]}; do
  symlink $t
done

# Plugin Manager
install_neobundle

exit 0
