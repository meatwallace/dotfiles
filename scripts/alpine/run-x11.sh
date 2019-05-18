#!/bin/sh

set -eu

x11docker \
  --name=meatbox-alpine \
  --desktop \
  --xephyr \
  --size=1280x720 \
  --gpu \
  --init=openrc \
  --runtime=nvidia \
  --dbus-system \
  --clipboard \
  --pulseaudio \
  --cap-default \
  --sudouser \
  --user=root \
  meatwallace/meatbox-alpine:latest awesome


# sudo x11docker \
#   --name=meatbox \
#   --desktop \
#   --hostdisplay \
#   --xorg \
#   --gpu \
#   --init=openrc \
#   --runtime=nvidia \
#   --dbus-system \
#   --clipboard \
#   --pulseaudio \
#   --cap-default \
#   meatwallace/meatbox-alpine:latest awesome
# --xephyr \
# --user=RETAIN \
# --sudouser \
