# bash

SETUP_SHELL=${SETUP_SHELL:-zsh}

DOT_FILES+=(
  .Brewfile
  .config/karabiner/assets/complex_modifications/toggle-ime-by-kana-key.json
)

case "${SETUP_SHELL}" in
  "bash" )
    DOT_FILES+=(
      .bash_profile.extra
      .bashrc.d/00-darwin.bashrc
    )
    ;;
  "zsh"  )
    DOT_FILES+=(
      .zshenv.extra
      .zshrc.d/00-darwin.zshrc
    )
    ;;
  * )
    echo "[error] Unexpected shell!! $SETUP_SHELL" >&2
    return 1
    ;;
esac
