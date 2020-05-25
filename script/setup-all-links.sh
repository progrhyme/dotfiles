#!/usr/bin/env bash

set -eu

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
source "${REPO_DIR}/lib/setup-common.bashrc"

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

DOTFILES=(
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
init

for df in ${DOTFILES[@]}; do
  symlink $df
done

exit 0
