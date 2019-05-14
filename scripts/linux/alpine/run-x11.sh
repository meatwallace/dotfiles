#!/bin/sh

sudo x11docker \
  --name=meatbox \
  --desktop \
  --hostdisplay \
  --xorg \
  --gpu \
  --init=openrc \
  --runtime=nvidia \
  --dbus-system \
  --clipboard \
  --pulseaudio \
  --cap-default \
  -- \
  --cap-add=SYS_ADMIN \
  -- \
  meatwallace/meatbox-alpine:latest awesome
  # --xephyr \
  # --user=RETAIN \
  # --sudouser \
