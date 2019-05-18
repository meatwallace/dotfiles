#!/bin/sh

set -eu

# make sure our terminal will support unicode
if ! sudo cat /etc/rc.conf | grep -q 'unicode="YES"'; then
  echo 'unicode="YES"' | sudo tee -a /etc/rc.conf
fi

