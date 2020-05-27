#!/usr/bin/env bash

set -euo pipefail

REPO_DIR=$(cd $(dirname $0)/.. && pwd)
source "${REPO_DIR}/lib/setup.bashrc"

SRCS=(
  "shrc.d/tmux.shrc"
)

case "$SHELL" in
  */bash )
    SRCS+=(
      "bashrc.d/peco.bashrc"
      "bashrc.d/10-load-git-completion.bashrc"
    )
    ;;
  */zsh )
    SRCS+=("zshrc.d/peco.zshrc")
    ;;
  * )
    ;;
esac

bootstrap

for rc in ${SRCS[@]}; do
  _rc=${rc##*/}
  symlink2 $rc $CUSTOM_RC_DIR/${_rc}
done

exit 0
