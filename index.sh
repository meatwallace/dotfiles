#!/bin/sh

set -e

# these are mirrored in the root .env file
export MEATBOX_DIR="$HOME"
export MEATBOX_BIN_DIR="$HOME/bin"
export MEATBOX_LIBS_DIR="$MEATBOX_DIR/libs"
export MEATBOX_SCRIPTS_DIR="$MEATBOX_DIR/scripts"

# make sure we're in the home dir
cd "$HOME"

# ensure the user has a /bin directory, and add it to the path
if [ ! -d "$MEATBOX_BIN_DIR" ]; then
  mkdir "$MEATBOX_BIN_DIR"
fi

export PATH="$MEATBOX_BIN_DIR:$PATH"

# pull down `yadm` and symlink it into our user's /bin
yadm_dir="$MEATBOX_LIBS_DIR/yadm"

if [ ! -d "$yadm_dir" ]; then
  git clone https://github.com/thelocehiliosan/yadm.git "$yadm_dir" >/dev/null

  ln -fs "$yadm_dir/yadm" "$MEATBOX_BIN_DIR/yadm"
fi

# clone our system config and update origin to use SSL in the future
yadm clone -f https://github.com/meatwallace/dotfiles >/dev/null
yadm remote set-url origin "git@github.com:meatwallace/dotfiles.git"

# check out a specific commit if it's been specified e.g. CI pull request
if [ -n "$MEATBOX_CHECKOUT_SHA1" ]; then
  yadm checkout "$MEATBOX_CHECKOUT_SHA1"
fi
