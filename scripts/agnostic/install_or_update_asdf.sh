#!/usr/bin/env bash

set -eux

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

# asdf returns an error code when no plugins are installed and we try to list
# them, cheers.
installed_plugin_packages="$(asdf current)"

desired_plugins="lua nodejs python ruby"

# add our version manager plugins
for plugin in $desired_plugins; do
  if ! echo "$installed_plugin_packages" | grep -q "$plugin"; then
    asdf plugin-add "$plugin"
    #>/dev/null 2>&1
  else
    asdf plugin-update "$plugin"
    #>/dev/null 2>&1
  fi
done

# import the nodejs GPG keys to verify installation
bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring" #>/dev/null 2>&1

# upgrade and use the latest versions of our packages
for plugin in $desired_plugins; do
  latest_version="$(asdf list-all "$plugin" | grep -E '^[0-9.]+$' | tail -n 1)"

  asdf install "$plugin" "$latest_version"
  #>/dev/null 2>&1
  asdf global "$plugin" "$latest_version"
  #>/dev/null
done
