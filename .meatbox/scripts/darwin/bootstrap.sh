#!/usr/bin/env bash

set -euo pipefail

declare -a scripts=(
  install_or_update_homebrew.sh
  install_mas.sh 
  install_or_update_linuxify.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done

