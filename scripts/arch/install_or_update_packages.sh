#!/bin/sh

set -eu

# grab the list of packages out of our "Yayfile" and diff it against the list
# of from packages via `yay` so we don't try to install anything unavailable
mkfifo available.fifo desired.fifo
yay -Slq | sort >available.fifo &
sort ./Yayfile >desired.fifo &
packages="$(comm -12 available.fifo desired.fifo)"

# install any packages that aren't installed or require updating
# shellcheck disable=SC2086
yay -Sq --noconfirm --needed --overwrite /etc/lightdm $packages >/dev/null
