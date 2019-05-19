#!/bin/sh

set -eu

curl https://cht.sh/:cht.sh > "$HOME/bin/cht.sh"
chmod +x "$HOME/bin/cht.sh"
curl https://cht.sh/:zsh > "$HOME/.zcompcache/_cht"

# cht.sh --standalone-install
