# bash

echo "Tests for lib/setup-common.bashrc"

t::group "REPO_DIR" ({
  . lib/setup-common.bashrc
  t_is "$(pwd)" "${REPO_DIR}" "REPO_DIR is this directory"
})

t::group "init_base_dir" ({
  mkdir -p tmp/src

  . lib/setup-common.bashrc

  REPO_DIR=tmp/src
  DOTFILES=tmp/dst

  init_base_dir
  t_symlink "$DOTFILES"
  t_is "$REPO_DIR" "$(readlink $DOTFILES)" "$DOTFILES -> $REPO_DIR"

  rm -rf tmp
})
