#!/bin/bash

set -e

############################################################
# Initialize

PROJECT=dotfiles
VIM_DIR=${HOME}/.vim
TARGETS=(.vimrc .vim/ftplugin .vim/ftdetect)

############################################################
# Functions

symlink() {
  file=$1;
  link="${HOME}/$file"
  real_file="${PROJECT}/${file}";

  if [ -L $link ]; then
    echo "[ok] already linked: ${link} -> ${real_file}";
    return 0;
  elif [ -d $link ]; then
    echo "[warn] directory already exists: $link";
    return 0;
  elif [ -f $link ]; then
    echo "[warn] file already exists: $link";
    return 0;
  fi

  if [ -e $real_file ]; then
    ln -s $real_file $link;
    echo "[ok] linked: $link -> ${real_file}";
  else
    echo "[error] not exist: ${real_file}";
    return 1;
  fi

  return 0;
}

############################################################
# Main

cd $HOME
if [ -e $PROJECT ]; then
  printf "${HOME}/$PROJECT exists\n";
else
  ln -s gitrepos/${PROJECT};
fi

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
  mkdir -p ${VIM_DIR}/bundle;
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim;
fi

