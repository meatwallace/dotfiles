#!/bin/sh

set -eu

install_yay() {
  # install `yay` if it's unavalable, a `pacman` wrapper that integrates the AUR
  if [ ! -x "$(command -v yay)" ]; then
    sudo pacman -S --noconfirm --config="$HOME/.config/pacman/pacman.conf" yay
  fi
}

install_yay "$@"
