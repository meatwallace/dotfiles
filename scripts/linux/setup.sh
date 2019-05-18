#!/bin/sh

set -eu

scripts="
  install_or_update_x11docker.sh
"

setup() {
  # ensure we have a fonts directory
  mkdir -p "$HOME/.local/share/fonts"

  for script in $scripts; do
    "./$script" >/dev/null
  done
}

setup
