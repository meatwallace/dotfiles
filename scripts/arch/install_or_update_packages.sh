#!/bin/sh

set -eu

# grab the list of packages out of our "Yayfile" and diff it against the list
# of from packages via `yay` so we don't try to install anything unavailable
mkfifo available.fifo desired.fifo
yay -Slq | sort >available.fifo &
sort ./Yayfile >desired.fifo &
packages="$(comm -12 available.fifo desired.fifo)"

# remove tizonia to accomodate issue @ https://git.io/fjOcN
if [ -x "$(command -v tizonia)" ]; then
  yay -R --noconfirm tizonia-all >/dev/null
fi

# install any packages that aren't installed or require updating
# shellcheck disable=SC2086
yay -Sq --noconfirm --needed --overwrite /etc/lightdm $packages >/dev/null
