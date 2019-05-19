#!/bin/sh

set -eu

sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys

# andontie-aur
sudo pacman-key --config="$HOME/.config/pacman/pacman.conf" --recv-key EA50C866329648EE >/dev/null
sudo pacman-key --config="$HOME/.config/pacman/pacman.conf" --lsign-key EA50C866329648EE >/dev/null
