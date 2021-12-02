#!/bin/sh

set -eu

scripts="
install_or_update_x11docker.sh
"

update() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

update "$@"

