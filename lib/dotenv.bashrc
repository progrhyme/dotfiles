# bash

DOTS_ROOT="${DOTS_ROOT:-$(cd $(dirname $BASH_SOURCE)/.. && pwd)}"
if [[ -z "${THE_ENV_DIR:-}" && -n "$MYENV" ]]; then
  THE_ENV_DIR="${DOTS_ROOT}/envs/${MYENV}"
fi

# Load target shell scripts
require() {
  local target="$1"
  local count=0

  if [[ -r "${DOTS_ROOT}/${target}" ]]; then
    count=$((++count))
    source "${DOTS_ROOT}/${target}"
  fi

  if [[ -n "${THE_ENV_DIR:-}" ]]; then
    if [[ -r "${THE_ENV_DIR}/${target}" ]]; then
      count=$((++count))
      source "${THE_ENV_DIR}/${target}"
    fi
  fi

  if ((count == 0)); then
    return 1
  fi
}

# Print path of target resource file
route() {
  local target="$1"

  if [[ -n "${THE_ENV_DIR:-}" ]]; then
    if [[ -e "${THE_ENV_DIR}/${target}" ]]; then
      echo "${THE_ENV_DIR}/${target}"
      return
    fi
  fi

  if [[ -e "${DOTS_ROOT}/${target}" ]]; then
    echo "${DOTS_ROOT}/${target}"
    return
  fi

  return 1
}
