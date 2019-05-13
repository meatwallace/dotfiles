#!/bin/sh

set -eu

if [ ! -x "$(command -v reflector)" ]; then
  sudo pacman -S --config="$HOME/.config/pacman/pacman.conf" --noconfirm reflector
fi

if [ -x "$(command -v asdf)" ]; then
  # use the system's version of python, where reflector is installed
  asdf shell python system
fi

reflector \
  --latest 200 \
  --protocol http \
  --protocol https \
  --sort rate \
  --save "$HOME/.config/pacman/mirrorlist"
