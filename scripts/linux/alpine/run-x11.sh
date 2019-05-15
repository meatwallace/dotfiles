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
  meatwallace/meatbox-alpine:latest awesome
# --xephyr \
# --user=RETAIN \
# --sudouser \
