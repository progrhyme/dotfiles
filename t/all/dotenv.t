# sh

t_diag "Tests for lib/dotenv.shrc"

mkdir -p tmp

t::group "Can't load lib/dotenv.shrc without DOTS_ROOT variable" ({
  unset DOTS_ROOT
  . lib/dotenv.shrc
  t_ne $? 0 "fail to source lib/dotenv.shrc"
})

t::group "With DOTS_ROOT set correctly" ({
  DOTS_ROOT=tmp
  echo "foo=bar" > tmp/.env
  t_diag "And when DOTS_ENV is not set"
  unset foo DOTS_ENV DOTS_ENV_DIR

  . lib/dotenv.shrc
  t_eq $? 0 "succeed to source lib/dotenv.shrc"
  t_blank "${DOTS_ENV_DIR:-}" "DOTS_ENV_DIR is blank"
  t_is "$(route .env)" "tmp/.env" "CMD 'route .env' => 'tmp/.env'"
  require .env
  t_eq $? 0 "CMD 'require .env' succeed"
  t_is "$foo" "bar" "foo = bar"
})

t::group "When \"test\" environment exists under the right DOTS_ROOT" ({
  mkdir -p tmp/envs/test
  DOTS_ROOT=tmp
  echo "foo=bar" > tmp/.env
  unset foo DOTS_ENV DOTS_ENV_DIR

  t::group "When DOTS_ENV=test" ({
    DOTS_ENV=test
    echo "foo=baz" > tmp/envs/test/.env

    . lib/dotenv.shrc
    t_eq $? 0 "succeed to source lib/dotenv.shrc"
    t_is $DOTS_ENV_DIR tmp/envs/test "DOTS_ENV_DIR = tmp/envs/test"
    t_is "$(route .env)" "tmp/envs/test/.env" "CMD 'route .env' => 'tmp/envs/test/.env'"
    require .env
    t_eq $? 0 "CMD 'require .env' succeed"
    t_is "$foo" "baz" "foo = baz"
  })

  t::group "When DOTS_ENV is invalid" ({
    echo "foo=baz" > tmp/envs/test/.env
    DOTS_ENV=no-such-env

    . lib/dotenv.shrc
    t_eq $? 0 "succeed to source lib/dotenv.shrc"
    t_is $DOTS_ENV_DIR tmp/envs/no-such-env "DOTS_ENV_DIR = tmp/envs/no-such-env"
    t_is "$(route .env)" "tmp/.env" "CMD 'route .env' => 'tmp/.env'"
    require .env
    t_eq $? 0 "CMD 'require .env' succeed"
    t_is "$foo" "bar" "foo = bar"
  })
})

rm -rf tmp
