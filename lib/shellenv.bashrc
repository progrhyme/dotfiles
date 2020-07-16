# bash

# Should be overridden by the environment
setup_shellenv() {
  :
}

# ============================================================
# Setup Functions

change_shell_to() {
  local target=$1
  if [[ ! -x $target ]]; then
    echo "[error] $target not executable!"
    return 1
  fi
  if [[ "$(basename $target)" = "$(basename $SHELL)" ]]; then
    echo "[notice] Already using $(basename $target). Skip."
    return
  fi
  sudo chsh -s $target
}

setup_basher() {
  require lib/basher.bashrc
  if [[ ! -d "${BASHER_ROOT}" ]]; then
    git clone https://github.com/basherpm/basher.git "${BASHER_ROOT}"
    require shrc.d/load_basher.shrc
  fi
  basher_bundle_install
}

setup_clenv() {
  CLENV_ROOT=${CLENV_ROOT:-$HOME/.clenv}
  if [[ ! -d "${CLENV_ROOT}" ]]; then
    git clone git@github.com:progrhyme/clenv.git "${CLENV_ROOT}"
    require shrc.d/load_clenv.shrc
  fi
  clam -r "$(route etc/Clamfile)"
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

install_binq() {
  if [[ ! -x $HOME/bin/binq ]]; then
  (
    pushd $HOME/bin
    curl -s "https://raw.githubusercontent.com/binqry/binq/master/get-binq.sh" | bash
    popd
  )
  fi
}
