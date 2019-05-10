#!/bin/sh

set -eo pipefail

# these are mirrored in the root .env file
export MEATBOX_DIR="$HOME/.meatbox"
export MEATBOX_BIN_DIR="$HOME/bin"
export MEATBOX_LIBS_DIR="$MEATBOX_DIR/libs"
export MEATBOX_SCRIPTS_DIR="$MEATBOX_DIR/scripts"

# make sure we're in the home dir
cd "$HOME"

# ensure the user has a /bin directory, and add it to the path
mkdir "$MEATBOX_BIN_DIR"

export PATH="$MEATBOX_BIN_DIR:$PATH"

# pull down `yadm` and symlink it into our user's /bin
YADM_DIR="$MEATBOX_LIBS_DIR/yadm"

if [ ! -d "$YADM_DIR" ]; then
  git clone https://github.com/TheLocehiliosan/yadm.git "$YADM_DIR" >/dev/null

  ln -fs "$YADM_DIR/yadm" "$MEATBOX_BIN_DIR/yadm"
fi

# clone our system config and update origin to use SSL in the future
yadm clone -f https://github.com/meatwallace/dotfiles >/dev/null
yadm remote set-url origin "git@github.com:meatwallace/dotfiles.git"

if [ -n "$MEATBOX_BRANCH" ]; then
  yadm checkout "$MEATBOX_BRANCH"
fi

# TODO(#37): remove once circle CI changes are merged to master
if [ ! -f "$HOME/bin/meatbox" ]; then
  ln -fs "$MEATBOX_SCRIPTS_DIR/meatbox.sh" "$MEATBOX_BIN_DIR/meatbox"
fi

# reload our bash_profile so our env is set up correctly
# shellcheck source=../.bash_profile
. "$HOME/.bash_profile"

# run our bootstrap command to ensure we have all of our dependencies
meatbox bootstrap

# reload our bash_profile again to ensure all our libs are sourced
# shellcheck source=../.bash_profile
. "$HOME/.bash_profile"

# setup our machine
meatbox setup
