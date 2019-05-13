#!/usr/bin/env bash

set -euo pipefail

# TODO(#20): differentiate between linux distros in our scripts to allow
# conditional script execution

declare -a scripts=(
  add_pacman_repo_keys.sh
  refresh_package_databases.sh
  update_pacman_mirrorlist.sh
  install_yay.sh
  install_pciutils.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done
