#!/bin/sh

set -eu

sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys

# andontie-aur
sudo pacman-key --config="$HOME/.config/pacman/pacman.conf" --recv-key B545E9B7CD906FE3 >/dev/null
sudo pacman-key --config="$HOME/.config/pacman/pacman.conf" --lsign-key B545E9B7CD906FE3 >/dev/null
