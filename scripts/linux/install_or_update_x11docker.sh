#!/bin/sh

set -e 

curl -fsSl https://raw.githubusercontent.com/mviereck/x11docker/master/x11docker | sudo bash -s -- --update >/dev/null
