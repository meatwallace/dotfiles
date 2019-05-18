#!/bin/sh

set -eu

scripts="
  add_edge_repositories.sh
  refresh_package_databases.sh
  install_pciutils.sh
"

bootstrap() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

bootstrap
