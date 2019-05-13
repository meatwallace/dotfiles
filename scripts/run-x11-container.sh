#!/bin/sh

x11docker \
  --name=meatbox \
  --desktop \
  --xephyr \
  --init=systemd \
  --init=openrc \
  --size=1840x1035 \
  --dbus-system \
  --user=RETAIN \
  --sudouser \
  --clipboard \
  --pulseaudio \
  --cap-default \
  -- \
  --cap-add=SYS_ADMIN \
  -- \
  meatwallace/meatbox:latest /usr/bin/xinitrcsession-helper
