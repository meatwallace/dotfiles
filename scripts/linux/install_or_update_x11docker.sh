#!/usr/bin/env bash

set -eo pipefail

curl -fsSl https://raw.githubusercontent.com/mviereck/x11docker/master/x11docker | sudo bash -s -- --update >/dev/null
