#!/usr/bin/env bash

if is not available "reflector"; then
  sudo pacman -S --config="$HOME/.config/pacman/pacman.conf" --noconfirm reflector
fi

# use the system's version of python, where reflector is installed
asdf shell python system

reflector \
  --latest 200 \
  --protocol http \
  --protocol https \
  --sort rate \
  --save "$HOME/.config/pacman/mirrorlist"
