#!/bin/sh

set -eu

install_or_update_packages() {
  # grab the list of packages out of our "Yayfile" and diff it against the list
  # of from packages via `yay` so we don't try to install anything unavailable
  tmpdir="$(mktemp -d)"
  mkfifo "$tmpdir/available_packages.fifo" "$tmpdir/desired_packages.fifo"
  yay -Slq | sort >"$tmpdir/available_packages.fifo" &
  sort ./Yayfile >"$tmpdir/desired_packages.fifo" &
  packages="$(comm -12 "$tmpdir/available_packages.fifo" "$tmpdir/desired_packages.fifo")"
  rm -rf "$tmpdir"

  # install any packages that aren't installed or require updating
  # shellcheck disable=SC2086
  yay -Sq --noconfirm --needed --overwrite /etc/lightdm $packages
}

install_or_update_packages "$@"
