#!/usr/bin/env bash

set -euo pipefail

if is not available "lspci"; then
  sudo pacman -S --noconfirm "pciutils" >/dev/null
fi
