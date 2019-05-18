#!/bin/sh

set -eu

scripts="
  add_pacman_repo_keys.sh
  refresh_package_databases.sh
  update_pacman_mirrorlist.sh
  install_yay.sh
  install_pciutils.sh
"

bootstrap() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

bootstrap
