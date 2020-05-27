#!/usr/bin/env bash

set -eu

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
source "${REPO_DIR}/lib/setup.bashrc"

case $SHELL in
  */bash)
    profiles=(
      .bash_profile
      .bashrc
      .git-completion.bash
    )
    ;;
  */zsh) profiles=(.zshenv .zshrc) ;;
  *)     profiles=() ;;
esac

DOT_FILES=(
  .config/git/ignore
  .gemrc
  .gitconfig
  .perltidyrc
  .rubocop.yml
  .tmux.conf
  .vimrc
  ${profiles[*]}
)

# ============================================================
# Main

bootstrap

for df in ${DOT_FILES[@]}; do
  symlink $df
done

exit
