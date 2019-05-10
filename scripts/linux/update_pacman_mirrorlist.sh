#!/usr/bin/env bash

if is not available "reflector"; then
  sudo pacman -S --config="$HOME/.config/pacman/pacman.conf" --noconfirm reflector
fi

reflector \
  --latest 200 \
  --protocol http \
  --protocol https \
  --sort rate \
  --save "$HOME/.config/pacman/mirrorlist"
