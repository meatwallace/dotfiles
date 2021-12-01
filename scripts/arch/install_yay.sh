#!/bin/sh

set -u

tempdir="$(mktemp -d .yay.XXXXXXXX)"

cleanup() {
  rm -rf "$tempdir"
}

trap cleanup 0

install_yay() {
  # install `yay` if it's unavalable, a `pacman` wrapper that integrates the AUR
  if [ ! -x "$(command -v yay)" ]; then
    git clone https://aur.archlinux.org/yay.git "$tempdir" >/dev/null
    cd "$HOME/.yay"
    makepkg -si --noconfirm
    cleanup
  fi
}

install_yay "$@"
