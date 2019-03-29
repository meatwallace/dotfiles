#!/usr/bin/env bash

set -euo pipefail

# grab the list of packages out of our "Yayfile" and diff it against the list
# of from packages via `yay` so we don't try to install anything unavailable
packages=$(comm -12 <(yay -Slq | sort) <(sort "./Yayfile"))

# remove tizonia to accomodate issue @ https://git.io/fjOcN
if is available "tizonia"; then
  yay -R --noconfirm tizonia-all >/dev/null
fi

# install any packages that aren't installed or require updating
yay -S --noconfirm --needed --overwrite /etc/lightdm $packages >/dev/null
