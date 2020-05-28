# bash
#
# Assume lib/setup.bashrc is loaded beforehand

DOT_FILES=(
  .config/git/ignore
  .gemrc
  .gitconfig
  .perltidyrc
  .rubocop.yml
  .tmux.conf
  .vimrc
)

CUSTOM_RC_FILES=(
  "shrc.d/tmux.shrc"
)

SETUP_SHELL=${SETUP_SHELL:-${SHELL##*/}}

case "${SETUP_SHELL}" in
  "bash" )
    DOT_FILES+=(
      .bash_profile
      .bashrc
      .git-completion.bash
    )
    CUSTOM_RC_FILES+=(
      "bashrc.d/peco.bashrc"
      "bashrc.d/10-load-git-completion.bashrc"
    )
    ;;
  "zsh" )
    DOT_FILES+=(.zshenv .zshrc)
    CUSTOM_RC_FILES+=("zshrc.d/peco.zshrc")
    ;;
  *) ;;
esac

# Use chain_home() by lib/setup.bashrc
link_dotfiles() {
  local df
  for df in "${DOT_FILES[@]}"; do
    chain_home $df
  done
}

# Use chain() by lib/setup.bashrc
link_custom_shrc_files() {
  local rc _rc
  for rc in "${CUSTOM_RC_FILES[@]}"; do
    _rc="${rc##*/}"
    chain "$rc" "${CUSTOM_RC_DIR}/${_rc}"
  done
}

setup_dotfiles() {
  link_dotfiles
  link_custom_shrc_files
}
