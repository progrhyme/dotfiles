# bash

# Assumptions:
#  - lib/setup.bashrc is required beforehand

require lib/dotfiles.bashrc

# Should be overridden by the environment
setup_shellenv() {
  # Defined in $DOTS_ROOT/lib/{dotfiles, shellenv}.bashrc
  setup_dotfiles
}
