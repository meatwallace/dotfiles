#!/bin/sh

set -eu

install_pciutils() {
  if [ ! -x "$(command -v lspci)" ]; then
    yay -S --noconfirm "pciutils" >/dev/null
  fi
}

install_pciutils "$@"

