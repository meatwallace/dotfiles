#!/bin/sh

set -eu

scripts="
set_system_defaults.sh
install_or_update_homebrew_packages.sh
update_system.sh
"

update() {
  for script in $scripts; do
    "./$script" >/dev/null
  done
}

update
