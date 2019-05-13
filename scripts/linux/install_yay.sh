#!/usr/bin/env bash

set -euo pipefail

# install `yay` if it's unavalable, a `pacman` wrapper that integrates the AUR
if [ ! -x "$(command -v yay)" ]; then
  sudo pacman -S --config "$HOME/.config/pacman/pacman.conf" --noconfirm yay
fi
