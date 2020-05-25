#!/usr/bin/env bash

set -euo pipefail

# Template config file exists as template/config/run-hugo-server
CONFIG="${CONFIG:-$HOME/.config/run-hugo-server}"

if [[ -r "$CONFIG" ]]; then
  source "$CONFIG"
fi

HUGO_PORT=${HUGO_PORT:-1313}
HUGO_OPTIONS="${HUGO_OPTIONS:-} --port ${HUGO_PORT}"
MODE=

if [[ -z "${HUGO_PROJECT_DIR:-}" ]]; then
  echo "[error] You must specify \$HUGO_PROJECT_DIR !"
  exit 1
fi

exit_on_hugo_port_use() {
  echo "[notice] localhost:$HUGO_PORT is already in use. Do nothing."
  exit 0
}

case "${1:-}" in
  "restart" ) MODE=restart ;;
  * ) ;;
esac

if [[ "$MODE" = "restart" ]]; then
  hugo_pids="$(pgrep hugo || true)"
  if [[ -n "${hugo_pids}" ]]; then
    echo "[notice] Hugo processes exist. Kill ${hugo_pids}"
    kill $hugo_pids
    sleep 1
  fi
elif command -v ss &>/dev/null; then
  if ss -nlt | grep "\b${HUGO_PORT}\b" &>/dev/null; then
    exit_on_hugo_port_use
  fi
elif netstat -an | grep LISTEN | grep "\b${HUGO_PORT}\b" &>/dev/null; then
  exit_on_hugo_port_use
fi

cd $HUGO_PROJECT_DIR
nohup hugo server ${HUGO_OPTIONS[@]} &>> /tmp/run-hugo-server.$(date +'%Y%m%d').log &

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<run-hugo-server.sh> - Run hugo server in specified directory

=head1 SYNOPSYS

    ./run-hugo-server.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>progrhyme@gmail.comE<gt>

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2020 IKEDA Kiyoshi

=cut

__EOF__

