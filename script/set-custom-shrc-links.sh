#!/usr/bin/env bash

set -euo pipefail

script_dir=${0%/*}
lib_dir="${script_dir}/../lib"
source "${lib_dir}/setup-common.bashrc"

SRCS=(
  "shrc.d/tmux.shrc"
)

case "$SHELL" in
  */bash )
    SRCS+=(
      "bashrc.d/peco.bashrc"
      "bashrc.d/load-git-completion.bashrc"
    )
    ;;
  */zsh )
    SRCS+=("zshrc.d/peco.zshrc")
    ;;
  * )
    ;;
esac

init

for rc in ${SRCS[@]}; do
  _rc=${rc##*/}
  symlink2 $rc $CUSTOM_RC_DIR/${_rc}
done

exit 0
