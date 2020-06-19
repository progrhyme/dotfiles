# enhancd (by shelp) + peco
if [[ -d "${SHELP_ROOT}/packages/enhancd" ]]; then
  ENHANCD_HYPHEN_ARG="-ls"
  ENHANCD_DOT_ARG="-up"
  ENHANCD_DISABLE_HOME=1
  include enhancd init.sh
  bind -x '"\C-ur": cd -ls'
  PECO_CD_CMD=__enhancd::cd
fi
