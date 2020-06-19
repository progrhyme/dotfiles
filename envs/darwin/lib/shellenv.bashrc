# bash

# Assumptions:
#  - lib/setup.bashrc is required beforehand
#  - SETUP_SHELL to be "bash" or "zsh"
#  - Default SHELL to be "zsh"

require lib/dotfiles.bashrc

SETUP_SHELL=${SETUP_SHELL:-zsh}

common_setup() {
  # Defined in $DOTS_ROOT/lib/{dotfiles, shellenv}.bashrc
  setup_dotfiles
}

# Should be overridden by the environment
setup_shellenv() {
  case "${SETUP_SHELL}" in
    "bash" )
      common_setup
      ;;
    "zsh"  )
      change_shell_to /usr/local/bin/zsh
      common_setup
      setup_ohmyzsh
      ;;
    * )
      echo "[error] Unexpected shell!! $SETUP_SHELL" >&2
      return 1
      ;;
  esac
}
