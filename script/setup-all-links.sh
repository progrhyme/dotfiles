#!/bin/bash

set -e

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
source "${REPO_DIR}/lib/setup-common.bashrc"

case $SHELL in
  */bash) profiles=(.bashrc .git-completion.bash) ;;
  */zsh)  profiles=(.zshenv .zshrc) ;;
  *)      profiles=() ;;
esac
DOTFILES=(.gitconfig .vimrc .perltidyrc .tmux.conf ${profiles[*]})
CMD=""

# ============================================================
# Main
init

for df in ${DOTFILES[@]}; do
  symlink $df
done

exit 0
