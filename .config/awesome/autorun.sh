#!/usr/bin/env bash

run-unique() {
  local process_name="$1"
  local cmd="${2:-$1}"

  if [ -x "$(command -v "$cmd")" ] && [ -z "$(pgrep "$process_name")" ]; then
    "$@" &
  fi
}

start-xcape() {
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -t 200 -e 'Caps_Lock=Escape;Control=Escape;Control_R=Escape'
}

run-unique xcape start-xcape
run-unique pulseaudio start-pulseaudio-x11
run-unique light-locker
run-unique compton

nvidia-settings --load-config-only
