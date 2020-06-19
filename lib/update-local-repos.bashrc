# bash
# Library for common/bin/update-local-repos

TMPD=$HOME/tmp/$PROG
DOTS_ROOT=${DOTS_ROOT:-$HOME/.dotfiles}

# lock & unlock
LOCK_DIR=$TMPD/lock.d
MAX_RETRY=4
SLEEP=2
MAX_SLEEP=10

get_lock() {
  local retry=0
  while true; do
    if mkdir $LOCK_DIR &>/dev/null; then
      if ((retry > 0)); then
        echo "[info] Succeeded to get lock."
      fi
      return 0
    fi
    ((++retry > MAX_RETRY)) && break
    echo "[notice] Failed to get lock. Retrying ... (${retry})"
    sleep $SLEEP
    # exponential backoff
    SLEEP=$((SLEEP*2))
    if ((SLEEP > MAX_SLEEP)); then
      SLEEP=$MAX_SLEEP
    fi
  done

  echo "[warn] Retry failed! Abort!"
  return 1
}

unlock() {
  rmdir $LOCK_DIR
}

cleanup_tmpdir() {
  find $TMPD -mtime +3 -exec rm -f {} \;
}

# should be overridden by the environment
update_local_env() {
  :
}

# update clenv/clam modules
update_clam_modules() {
  tsfile="$TMPD/clam-modules.$YMD"
  if [[ $FORCE || ! -e $tsfile ]]; then
    clam -r $DOTS_ROOT/etc/Clamfile
    rm -f "$TMPD/clam-modules.*"
    touch $tsfile
  fi
}

# check if basher packages outdated
check_basher_outdated() {
  local tsfile="${TMPD}/basher.${YMD}"
  local bp
  if [[ $FORCE || ! -e $tsfile ]]; then
    for bp in $(basher outdated); do
      echo "[info] basher upgrade $bp"
      basher upgrade $bp
    done
    rm -f "$TMPD/basher.*"
    touch $tsfile
  fi
}

# update shelp packages
update_shelp_packages() {
  local tsfile="${TMPD}/shelp.${YMD}"
  if [[ $FORCE || ! -e $tsfile ]]; then
    shelp bundle
    shelp upgrade
    rm -f "$TMPD/shelp.*"
    touch $tsfile
  fi
}
