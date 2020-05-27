# bash

t_diag "Tests for lib/setup.bashrc"

t::group "REPO_DIR" ({
  . lib/setup.bashrc
  t_is "$(pwd)" "${REPO_DIR}" "REPO_DIR is this directory"
})

t::group "init_base_dir" ({
  mkdir -p tmp/src

  . lib/setup.bashrc

  REPO_DIR=tmp/src
  DOTS_ROOT=tmp/dst

  link_dots_root
  t_symlink "$DOTS_ROOT"
  t_is "$REPO_DIR" "$(readlink $DOTS_ROOT)" "$DOTS_ROOT -> $REPO_DIR"

  rm -rf tmp
})
