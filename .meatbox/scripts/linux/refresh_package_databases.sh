#!/usr/bin/env bash

set -euo pipefail

if is available "yay"; then
  yay -Syy # >/dev/null
else
  sudo pacman -Syy # >/dev/null
fi
