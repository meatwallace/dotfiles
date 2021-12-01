#!/bin/sh

set -eu

add_pacman_repo_keys() {
  sudo pacman -Sy archlinux-keyring --noconfirm
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
}

add_pacman_repo_keys "$@"

