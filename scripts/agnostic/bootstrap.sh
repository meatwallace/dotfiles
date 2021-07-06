#!/bin/sh

set -eu

scripts="
install_neofetch.sh
install_or_update_asdf.sh
install_yarn.sh
"

bootstrap() {
  for script in $scripts; do
    "./$script" "$@"
  done
}

bootstrap "$@"
