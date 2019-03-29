#!/usr/bin/env bash

set -euo pipefail

MEATBOX_USER=${MEATBOX_USER:-meatwallace}
MEATBOX_PASSWORD=${MEATBOX_PASSWORD:-meatword}

docker build . \
  --build-arg "MEATBOX_USER=$MEATBOX_USER" \
  --build-arg "MEATBOX_PASSWORD=$MEATBOX_PASSWORD" \
  --build-arg "CACHE_BUSTER=$(date +%s)" \
  --tag meatwallace/meatbox:latest
