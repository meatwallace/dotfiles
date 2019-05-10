#!/usr/bin/env bash

set -euo pipefail

# install `aria2` if we don't have it, as we require it to support parallel
# downloading in `app-fast`. use `pacman` directly as `yay` is configured
# to use `app-fast` as it's `pacman` bin
if is not available "aria2c"; then
  yay -S --noconfirm aria2 >/dev/null
fi
