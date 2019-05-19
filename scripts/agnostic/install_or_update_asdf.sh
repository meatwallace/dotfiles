#!/usr/bin/env bash

set -eu

asdf_dir="$MEATBOX_LIBS_DIR/asdf"

if [ ! -x "$(command -v asdf)" ]; then
  # clone in our version manager
  git clone https://github.com/asdf-vm/asdf.git "$asdf_dir" >/dev/null

  (cd "$asdf_dir" && git checkout "$(git describe --abbrev=0 --tags)") >/dev/null

  # disable variable checking as `asdf` will blow up when we source it
  set +u

  # shellcheck source=../../libs/asdf/asdf.sh
  . "$asdf_dir/asdf.sh"

  set -u
else
  asdf update >/dev/null 2>&1
fi

# another ugly workaround - should just install unzip prior
if [ ! -x "$(command -v unzip)" ]; then
  if [ -x "$(command -v pacman)" ]; then
    sudo pacman -Sy --noconfirm --needed unzip
  elif [ -x "$(command -v apk)" ]; then
    sudo apk add --no-cache unzip
  else
    echo "unsupported distro"
    exit 1
  fi
fi

installed_plugin_packages="$(asdf current)"
desired_plugins="lua python ruby"

# hacky workaround to avoid installing nodejs on alpine as we'd need to compile
# from source if using asdf
if ! echo "$@" | grep "alpine"; then
  desired_plugins="$desired_plugins nodejs"
fi

# add our version manager plugins
for plugin in $desired_plugins; do
  if ! echo "$installed_plugin_packages" | grep -q "$plugin"; then
    asdf plugin-add "$plugin" >/dev/null 2>&1
  else
    asdf plugin-update "$plugin" >/dev/null 2>&1
  fi
done

# as we don't manage node via asdf on alpine, this keyring script won't exist
if echo "$desired_plugins" | grep "nodejs"; then
  # import the nodejs GPG keys to verify installation
  bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring" >/dev/null 2>&1
fi

# upgrade and use the latest versions of our packages
for plugin in $desired_plugins; do
  latest_version="$(asdf list-all "$plugin" | grep -E '^[0-9.]+$' | tail -n 1)"

  # this compiles node.js from source as a workaround as there's no prebuilt
  # binary. as that takes 6 years, we opt to just install the latest node via
  # the alpine repo instead
  # if [ "$plugin" = "nodejs" ] & [ ! -f "$HOME/.asdf/installs/nodejs/$latest_version/bin/node" ]; then
  #   export NODEJS_CHECK_SIGNATURES="no"
  #   latest_version="ref:v$latest_version"
  # fi

  asdf install "$plugin" "$latest_version" >/dev/null 2>&1
  asdf global "$plugin" "$latest_version" >/dev/null
done
