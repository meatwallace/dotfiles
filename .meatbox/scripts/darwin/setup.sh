#!/usr/bin/env bash

set -euo pipefail

declare -a scripts=(
  set_system_defaults.sh 
  install_or_update_homebrew_packages.sh
  update_system.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done

