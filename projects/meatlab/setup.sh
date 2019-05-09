#!/usr/bin/env bash

set -euo pipefail

mkdir -p "$HOME"/containers/heimdall/config
mkdir -p "$HOME"/containers/plex/{config,transcode}
mkdir -p "$HOME"/containers/downloads/completed/{movies,tv}

(cd "$MEATLAB_DIR" && docker-compose up -d)
