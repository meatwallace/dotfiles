#!/usr/bin/env bash

if is not available "reflector"; then
  sudo pacman -S --noconfirm reflector
fi

reflector \
  --latest 200 \
  --protocol http \
  --protocol https \
  --sort rate \
  --save "$HOME/.config/pacman/mirrorlist"
