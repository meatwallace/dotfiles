#!/bin/sh

set -eu

x11docker \
  --name=meatbox-alpine \
  --desktop \
  --gpu \
  --xephyr \
  --size=1280x720 \
  --init=openrc \
  --runtime=nvidia \
  --dbus-system \
  --clipboard \
  --pulseaudio \
  --cap-default \
  --sudouser \
  --user=RETAIN \
  -- \
  --volume="/var/run/docker.sock:/var/run/docker.sock" \
  --volume="/home/$USER/projects:/home/$USER/projects" \
  --privileged \
  --cap-add=ALL \
  -- \
  meatwallace/meatbox-alpine:latest "/home/$USER/.xinitrc"

  # --hostdisplay \
  # --xorg
  # --fullscreen
