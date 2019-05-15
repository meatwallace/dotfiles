#!/bin/sh

set -eu

if [ ! -x "$(command -v mas)" ]; then
  macos_version="$(defaults read loginwindow SystemVersionStampAsString)"
  short_version="${macos_version%.*}"
  high_sierra_version="10.13"

  # if we're using a version older than High Sierra, use the legacy tap
  if [ "$(echo "$short_version $high_sierra_version" | awk '{if \($1 > $2\) print $1; else print $2}')" -eq $high_sierra_version ]; then
    brew tap mas-cli/tap >/dev/null
    brew tap-pin mas-cli/tap >/dev/null
  fi

  brew install "mas" >/dev/null
fi
