#!/bin/sh

set -eu

install_or_update_snaps() {
  # allow the installation of classic snaps
  if ! ls /snap/ >/dev/null; then
    ln -s /var/lib/snapd/snap /snap
  fi

  # update existing snaps
  sudo snap refresh

  # grab the list of snaps out of our "Snapfile":w
  packages="$(strip-comments ./Snapfile | sort)"

  # install any missing packages
  sudo snap install $packages >/dev/null
}

install_or_update_snaps "$@"
