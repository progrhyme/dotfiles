# bash

SETUP_SHELL=${SETUP_SHELL:-zsh}

DOT_FILES+=(
  .shelp/config.yml
)

case "${SETUP_SHELL}" in
  "bash" )
    DOT_FILES+=(
      .bash_profile.extra
      .bashrc.d/00-ubuntu-desktop.bashrc
    )
    ;;
  "zsh"  )
    DOT_FILES+=(
      .Brewfile
      .zshenv.extra
      .zshrc.d/00-ubuntu-desktop.zshrc
    )
    ;;
  * )
    echo "[error] Unexpected shell!! $SETUP_SHELL" >&2
    return 1
    ;;
esac
