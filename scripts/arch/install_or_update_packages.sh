#!/bin/sh

set -eu

install_or_update_packages() {
  # grab the list of packages out of our "Yayfile" and diff it against the list
  # of from packages via `yay` so we don't try to install anything unavailable
  tmpdir="$(mktemp -d)"
  mkfifo "$tmpdir/available.fifo" "$tmpdir/desired.fifo"
  yay -Slq | sort >"$tmpdir/available.fifo" &
  sort ./Yayfile >"$tmpdir/desired.fifo" &
  packages="$(comm -12 "$tmpdir/available.fifo" "$tmpdir/desired.fifo")"
  rm -rf "$tmpdir"

  # install any packages that aren't installed or require updating
  # shellcheck disable=SC2086
  yay -Sq --noconfirm --needed --overwrite /etc/lightdm $packages >/dev/null
}

install_or_update_packages "$@"
