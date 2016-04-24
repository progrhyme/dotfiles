#!/bin/bash

set -e

script_dir=${0%/*}
lib_dir="${script_dir}/../lib"
source "${lib_dir}/setup-common.bashrc"

case $SHELL in
  */bash) profiles=(.bashrc .git-completion.bash) ;;
  */zsh)  profiles=(.zshenv .zshrc) ;;
  *)      profiles=() ;;
esac
DOTFILES=(.gitconfig .vimrc .perltidyrc .screenrc ${profiles[*]})
CMD=""

# ============================================================
# Main
init

for df in ${DOTFILES[@]}; do
  symlink $df
done

exit 0
