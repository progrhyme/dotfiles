#!/usr/bin/env bash

set -euo pipefail

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
source "${REPO_DIR}/lib/setup-common.bashrc"

VIM_DIR=${HOME}/.vim
TARGETS=(.vimrc .vim/ftplugin .vim/ftdetect .vim/template)

# for Plugin Managers
NEOBUNDLE_DIR=${VIM_DIR}/bundle
DEIN_DIR=${VIM_DIR}/dein
DEIN=${DEIN:-}

# ============================================================
# Functions
install_neobundle() {
  if [[ ! -d $NEOBUNDLE_DIR ]]; then
    local workrepo="${bundle_dir}/neobundle.vim"
    mkdir -p $NEOBUNDLE_DIR
    git clone https://github.com/Shougo/neobundle.vim $workrepo
  fi
}

install_dein() {
  if [[ ! -d $DEIN_DIR ]]; then
    mkdir -p $DEIN_DIR
    (
      cd $DEIN_DIR
      curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
      sh ./installer.sh $DEIN_DIR
    )
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

# Install Plugin Manager
if [[ -n "${DEIN}" ]]; then
  install_dein
else
  install_neobundle
fi

exit 0
