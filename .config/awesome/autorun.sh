#!/bin/sh

run_unique() {
  process_name="$1"
  cmd="${2:-$1}"

  if [ -x "$(command -v "$cmd")" ] && [ -z "$(pgrep "$process_name")" ]; then
    "$@" &
  fi
}

start_xcape() {
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -t 200 -e 'Caps_Lock=Escape;Control=Escape;Control_R=Escape'
}

run_unique xcape start-xcape
run_unique pulseaudio start-pulseaudio-x11
run_unique light-locker
run_unique compton

nvidia-settings --load-config-only
