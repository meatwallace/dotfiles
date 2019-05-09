#!/usr/bin/env bash

set -euo pipefail

declare -a scripts=(
  install_or_update_node_modules.sh
  install_or_update_python_packages.sh
  install_or_update_ruby_gems.sh
  install_or_update_zplugin.sh
  load_zsh.sh
)

for script in "${scripts[@]}"; do
  "./$script" >/dev/null
done
