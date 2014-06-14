#!/bin/bash

PROJECT=dotfiles
VIM_DIR=${HOME}/.vim
TARGETS=(.vimrc .vim/ftplugin)

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
  if [ -e $t ]; then
    printf "${HOME}/$t exists\n"
  else
    ln -s $PROJECT/$t
  fi
done

