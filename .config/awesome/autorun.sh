#!/bin/sh

run_unique() {
  process_name="$1"
  cmd="${2:-$1}"

  if command -v "$cmd" && [ -z "$(pgrep "$process_name")" ]; then
    "$cmd" &
  fi
}

start_xcape() {
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -t 200 -e 'Caps_Lock=Escape;Control=Escape;Control_R=Escape'
}

start_insync() {
  trickle -s -t 5 -l 20 -d 500 -u 50 insync start
}

run_unique xcape start-xcape
run_unique insync start_insync
run_unique pulseaudio start-pulseaudio-x11
run_unique light-locker
run_unique compton
run_unique bt-agent
run_unique transmission-daemon
run_unique mpd

nvidia-settings --load-config-only
