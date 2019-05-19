#!/bin/sh

set -eu

scripts="
install_or_update_asdf.sh
install_yarn.sh
"

bootstrap() {
  for script in $scripts; do
    "./$script" "$@" >/dev/null
  done
}

bootstrap "$@"
