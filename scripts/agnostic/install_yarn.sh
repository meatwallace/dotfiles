#!/bin/sh

set -eu

install_yarn() {
  if ! command -v yarn; then
    if sysinfo distro | grep -q "alpine"; then
      sudo apk add --no-cache yarn
    else
      sudo pacman -Sy --noconfirm --config="$HOME/.config/pacman/pacman.conf" yarn
    fi
  fi
}

install_yarn "$@"
