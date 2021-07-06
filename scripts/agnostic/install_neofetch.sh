#!/bin/sh

set -eu

install_neofetch() {
  if ! command -v neofetch; then
	  if [ "$(uname -s)" == "Darwin" ]; then
      brew install neofetch
    elif get-distro-id | grep -q "alpine"; then
      sudo apk add --no-cache neofetch
    else
      sudo pacman -Sy --noconfirm --config="$HOME/.config/pacman/pacman.conf" neofetch
    fi
  fi
}

install_neofetch "$@"
