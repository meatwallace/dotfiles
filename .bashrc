#!/usr/bin/env bash

# shellcheck source=.profile
. "$HOME/.profile"

ASDF_DIR="$MEATBOX_LIBS_DIR/asdf"

# load `asdf`, our version manager
if [ -d "$ASDF_DIR" ]; then
  # shellcheck source=libs/asdf/asdf.sh
  . "$ASDF_DIR/asdf.sh"
fi
