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

setup_ohmyzsh() {
  local ohmyzsh=$HOME/.oh-my-zsh
  local ohmyzsh_custom_plugins=(
    https://github.com/zsh-users/zsh-autosuggestions
  )
  local git_uri _basename _plugin_dir

  if [[ ! -d $ohmyzsh ]]; then
    # Install oh-my-zsh
    curl -Lo /tmp/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    RUNZSH=no sh /tmp/install.sh
  fi

  for git_uri in "${ohmyzsh_custom_plugins[@]}"; do
    _basename=${git_uri##*/}
    _basename=${_basename%.git}
    _plugin_dir="${ohmyzsh}/custom/plugins/${_basename}"
    if [[ ! -d $_plugin_dir ]]; then
      git clone $git_uri $_plugin_dir
    fi
  done
}

# Should be overridden by the environment
setup_shellenv() {
  case "${SETUP_SHELL}" in
    "bash" )
      common_setup
      ;;
    "zsh"  )
      change_shell_to /bin/zsh
      common_setup
      setup_ohmyzsh
      ;;
    * )
      echo "[error] Unexpected shell!! $SETUP_SHELL" >&2
      return 1
      ;;
  esac
}
