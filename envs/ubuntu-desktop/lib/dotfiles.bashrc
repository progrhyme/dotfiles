# bash

SETUP_SHELL=${SETUP_SHELL:-zsh}

case "${SETUP_SHELL}" in
  "bash" )
    DOT_OMIT_FILES+=(
      bash_profile.extra
      bashrc.d/00-ubuntu-desktop.bashrc
    )
    ;;
  "zsh"  )
    DOT_OMIT_FILES+=(
      Brewfile
      zshenv.extra
      zshrc.d/00-ubuntu-desktop.zshrc
    )
    ;;
  * )
    echo "[error] Unexpected shell!! $SETUP_SHELL" >&2
    return 1
    ;;
esac
