#!/bin/sh

set -eu

refresh_package_databases() {
  if [ -x "$(command -v yay)" ]; then
    yay -Syy >/dev/null
  else
    sudo pacman -Syy --config "$HOME/.config/pacman/pacman.conf" >/dev/null
  fi
}

refresh_package_databases "$@"

