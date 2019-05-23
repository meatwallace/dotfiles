#!/usr/bin/env bash

# shellcheck source=.profile
. "$HOME/.profile"

asdf_dir="$MEATBOX_LIBS_DIR/asdf"

# load `asdf`, our version manager
if [ -d "$asdf_dir" ]; then
  # shellcheck source=libs/asdf/asdf.sh
  . "$asdf_dir/asdf.sh"
fi

# if we're on mac, we'll be using `fastlane`, which requires we're setting
# our language universally to `en_US.UTF8` for some reason
if [ -x "$(command -v fastlane)" ] && [ "$(sysinfo os)" = "macos" ]; then
  export LANG="en_US.UTF8"
  export LANGUAGE="en_US.UTF8"
  export LC_ALL="en_US.UTF"
fi
