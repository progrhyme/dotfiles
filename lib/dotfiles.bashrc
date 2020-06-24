# bash
#
# Assume lib/setup.bashrc is loaded beforehand

DOT_FILES=()

DOT_OMIT_FILES=(
  config/git/ignore
  config/run-hugo-server
  gemrc
  gitconfig
  perltidyrc
  rubocop.yml
  tmux.conf
  vimrc
  shelp/config.yml
)

CUSTOM_RC_FILES=(
  "shrc.d/tmux.shrc"
)

SETUP_SHELL=${SETUP_SHELL:-${SHELL##*/}}

case "${SETUP_SHELL}" in
  "bash" )
    DOT_OMIT_FILES+=(
      bash_profile
      bashrc
      git-completion.bash
    )
    CUSTOM_RC_FILES+=(
      "bashrc.d/peco.bashrc"
      "bashrc.d/10-load-git-completion.bashrc"
    )
    ;;
  "zsh" )
    DOT_OMIT_FILES+=(zshenv zshrc)
    CUSTOM_RC_FILES+=("zshrc.d/peco.zshrc")
    ;;
  *) ;;
esac

# Use link_b2a() & link_home() by dot-sh
link_dotfiles() {
  local df dst
  for df in "${DOT_FILES[@]}"; do
    link_home $df
  done
  for df in "${DOT_OMIT_FILES[@]}"; do
    dst="${HOME}/.$df"
    link_b2a $df $dst
  done
}

# Use link_b2a() by lib/setup.bashrc
link_custom_shrc_files() {
  local rc _rc
  for rc in "${CUSTOM_RC_FILES[@]}"; do
    _rc="${rc##*/}"
    link_b2a "$rc" "${CUSTOM_RC_DIR}/${_rc}"
  done
}

setup_dotfiles() {
  link_dotfiles
  link_custom_shrc_files
}
