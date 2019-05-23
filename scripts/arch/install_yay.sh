#!/bin/sh

set -eu

install_yay() {
  # install `yay` if it's unavalable, a `pacman` wrapper that integrates the AUR
  if [ ! -x "$(command -v yay)" ]; then
    meatman add yay
  fi
}

install_yay
