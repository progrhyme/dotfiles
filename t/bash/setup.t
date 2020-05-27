# bash

t_diag "Tests for lib/setup.bashrc"

t::group "REPO_DIR" ({
  source lib/setup.bashrc
  t_is "$(pwd)" "${REPO_DIR}" "REPO_DIR is this directory"
})

t::group "THE_ENV_DIR" ({
  t::group "Without MYENV" ({
    unset MYENV THE_ENV_DIR
    source lib/setup.bashrc
    t_blank "$THE_ENV_DIR" "THE_ENV_DIR is blank"
  })

  t::group "With MYENV = __test__" ({
    MYENV=__test__
    unset THE_ENV_DIR

    t::group "When THE_ENV_DIR exists" ({
      mkdir -p envs/$MYENV
      source lib/setup.bashrc
      t_is "$THE_ENV_DIR" "${REPO_DIR}/envs/$MYENV" "THE_ENV_DIR = ${REPO_DIR}/envs/$MYENV"
      rm -rf envs/$MYENV
    })

    # Fails because "lib/dotenv.shrc" is loaded in "lib/setup.bahsrc"
    #t::group "When THE_ENV_DIR doesn't exist" ({
      #source lib/setup.bashrc
      #t_blank "$THE_ENV_DIR" "THE_ENV_DIR is blank"
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
