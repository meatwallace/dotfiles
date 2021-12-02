#!/usr/bin/env bash

set -e

update_pacman_mirrorlist() {
  # bail out early if we're on CI
  if [ "$CI" = "true" ]; then
    return 0
  fi

  if [ ! -x "$(command -v reflector)" ]; then
    sudo pacman -Sy --config="$HOME/.config/pacman/pacman.conf" --noconfirm reflector >/dev/null 2>&1
  fi

  if [ -x "$(command -v asdf)" ]; then
    set +u
    # shellcheck source=../../.bashrc
    . "$HOME/.bashrc"
    set -u

    # use the system's version of python, where reflector is installed
    asdf shell python system
  fi

  reflector \
    --latest 200 \
    --protocol http \
    --protocol https \
    --sort rate \
    --save "$HOME/.config/pacman/mirrorlist"
}

update_pacman_mirrorlist "$@"

