#!/bin/bash

set -e

script_dir=${0%/*}
lib_dir="${script_dir}/../lib"
source "${lib_dir}/setup-common.bashrc"

VIM_DIR=${HOME}/.vim
TARGETS=(.vimrc .vim/ftplugin .vim/ftdetect .vim/template)

# ============================================================
# Main
init_base_dir

# create ~/.vim
if [ ! -d ${VIM_DIR} ]; then
  mkdir -p ${VIM_DIR};
fi

# create symlinks
for t in ${TARGETS[@]}; do
  symlink $t
done

# for NeoBundle
if [ ! -d ${VIM_DIR}/bundle ]; then
  mkdir -p ${VIM_DIR}/bundle
  git clone https://github.com/Shougo/neobundle.vim ${VIM_DIR}/bundle/neobundle.vim
fi

exit 0
