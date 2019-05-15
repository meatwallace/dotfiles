#!/bin/sh

sudo x11docker \
  --name=meatbox \
  --desktop \
  --hostdisplay \
  --xorg \
  --gpu \
  --init=systemd \
  --runtime=nvidia \
  --dbus-system \
  --clipboard \
  --pulseaudio \
  --cap-default \
  --user=RETAIN \
  --sudouser \
  -- \
  --cap-add=SYS_ADMIN \
  -- \
  meatwallace/meatbox-arch:latest /usr/bin/xinitrcsession-helper
  # --fullscreen \
  # --size=1840x1035 \
  # --xephyr \
  # --init=openrc \
