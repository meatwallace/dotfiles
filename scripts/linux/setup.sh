#!/bin/sh

set -eu

scripts="
install_or_update_x11docker.sh
"

fonts_dir="$HOME/.local/share/fonts"

setup() {
  # ensure we have a fonts directory
  if [ ! -d "$fonts_dir" ]; then
    mkdir -p "$fonts_dir"
  fi

  for script in $scripts; do
    "./$script" >/dev/null
  done
}

setup "$@"
