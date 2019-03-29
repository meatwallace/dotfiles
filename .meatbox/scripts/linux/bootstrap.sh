#!/usr/bin/env bash

set -euo pipefail

# TODO(#20): differentiate between linux distros in our scripts to allow
# conditional script execution

declare -a scripts=(
  refresh_package_databases.sh
  install_yay.sh
  install_pciutils.sh
  install_aria2.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done
