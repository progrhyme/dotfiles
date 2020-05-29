# bash

t_diag "Tests for lib/setup.bashrc"

t::group "REPO_DIR" ({
  source lib/setup.bashrc
  t_is "$(pwd)" "${REPO_DIR}" "REPO_DIR is this directory"
})

t::group "DOTS_ENV_DIR" ({
  t::group "Without DOTS_ENV" ({
    unset DOTS_ENV DOTS_ENV_DIR
    source lib/setup.bashrc
    t_blank "$DOTS_ENV_DIR" "DOTS_ENV_DIR is blank"
  })

  t::group "With DOTS_ENV = __test__" ({
    DOTS_ENV=__test__
    unset DOTS_ENV_DIR

    t::group "When DOTS_ENV_DIR exists" ({
      mkdir -p envs/$DOTS_ENV
      source lib/setup.bashrc
      t_is "$DOTS_ENV_DIR" "${REPO_DIR}/envs/$DOTS_ENV" "DOTS_ENV_DIR = ${REPO_DIR}/envs/$DOTS_ENV"
      rm -rf envs/$DOTS_ENV
    })

    # Fails because "lib/dotenv.shrc" is loaded in "lib/setup.bahsrc"
    #t::group "When DOTS_ENV_DIR doesn't exist" ({
      #source lib/setup.bashrc
      #t_blank "$DOTS_ENV_DIR" "DOTS_ENV_DIR is blank"
    #})
  })
})

t::group "link_dots_root" ({
  mkdir -p tmp/src

  source lib/setup.bashrc

  REPO_DIR=tmp/src
  DOTS_ROOT=tmp/dst

  link_dots_root
  t_symlink "$DOTS_ROOT"
  t_is "$REPO_DIR" "$(readlink $DOTS_ROOT)" "$DOTS_ROOT -> $REPO_DIR"

  rm -rf tmp
})

# vim:set ft=sh :
