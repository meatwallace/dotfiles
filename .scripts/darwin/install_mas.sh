#!/usr/bin/env bash

if is not available "mas"; then
  macos_version="$(defaults read loginwindow SystemVersionStampAsString)"
  short_version="${macos_version%.*}"

  # if we're using a version older than High Sierra, use the legacy tap 
  if is lt "$short_version" "10.13"; then
    brew tap mas-cli/tap >/dev/null
    brew tap-pin mas-cli/tap >/dev/null
  fi
  
  brew install "mas" >/dev/null
fi

