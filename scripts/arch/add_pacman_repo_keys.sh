#!/bin/sh

set -eu

# andontie-aur
sudo pacman-key --recv-key EA50C866329648EE >/dev/null
sudo pacman-key --lsign-key EA50C866329648EE >/dev/null
