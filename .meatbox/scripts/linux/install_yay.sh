#!/usr/bin/env bash

set -euo pipefail

# install `yay` if it's unavalable, a `pacman` wrapper that integrates the AUR
if is not available "yay"; then
  yay_source_dir=$(mktemp -d)

  git clone https://aur.archlinux.org/yay.git "$yay_source_dir"

  (cd "$yay_source_dir" && makepkg -si --noconfirm >/dev/null)

  rm -rf "$yay_source_dir"
fi
