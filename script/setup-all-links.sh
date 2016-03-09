#!/bin/bash

PROJECT=dotfiles
case $SHELL in
  */bash) profiles=(.bashrc .git-completion.bash) ;;
  */zsh)  profiles=(.zshenv .zshrc) ;;
  *)      profiles=() ;;
esac
DOTFILES=(.gitconfig .vimrc .perltidyrc .screenrc ${profiles[*]})
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

# create .zshrc.d
if [ ! -d $HOME/.zshrc.d ]; then
  mkdir $HOME/.zshrc.d
fi
