#!/bin/bash

PROJECT=dotfiles
DOTFILES=(.gitconfig .zshenv .zshrc .vimrc)
CMD=""

cd $HOME
if [ -e $PROJECT ]; then
  printf "${HOME}/$PROJECT exists\n"
else
  ln -s gitrepos/${PROJECT}
fi

for file in ${DOTFILES[@]}; do
  if [ -e $file ]; then
    printf "${HOME}/$file exists\n"
  else
    ln -s $PROJECT/$file
  fi
done

