#!/bin/sh

set -eu

scripts="
install_or_update_homebrew.sh
install_mas.sh 
install_or_update_linuxify.sh
"

bootstrap() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

bootstrap
