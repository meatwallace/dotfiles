#!/bin/sh

set -eu

if [ -x "$(command -v yay)" ]; then
  yay -Syy >/dev/null
else
  sudo pacman -Syy --config "$HOME/.config/pacman/pacman.conf" >/dev/null
fi
