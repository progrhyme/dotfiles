# enhancd (by basher) + peco
if [[ -d "${BASHER_PACKAGES_PATH}/b4b4r07/enhancd" ]]; then
  ENHANCD_HYPHEN_ARG="-ls"
  ENHANCD_DOT_ARG="-up"
  ENHANCD_DISABLE_HOME=1
  include b4b4r07/enhancd init.sh
  bind -x '"\C-ur": cd -ls'
  PECO_CD_CMD=__enhancd::cd
fi
