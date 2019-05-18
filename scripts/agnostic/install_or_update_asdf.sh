#!/bin/sh

set -eu

asdf_dir="$MEATBOX_LIBS_DIR/asdf"

if [ ! -x "$(command -v asdf)" ]; then
  # TODO(#27): create an `unzip` install script as `lua` requires it
  sudo pacman -Sy --noconfirm unzip >/dev/null

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

# asdf returns an error code when no plugins are installed and we try to list
# them, cheers.
set +e
installed_plugins="$(asdf plugin-list)"
set -e

desired_plugins="lua nodejs python ruby"

# add our version manager plugins
for plugin in $desired_plugins; do
  if ! echo "$installed_plugins" | grep -q "$plugin"; then
    asdf plugin-add "$plugin" >/dev/null 2>&1
  else
    asdf plugin-update "$plugin" >/dev/null 2>&1
  fi
done

# import the nodejs GPG keys to verify installation
bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring" >/dev/null 2>&1

# upgrade and use the latest versions of our packages
for plugin in $desired_plugins; do
  latest_version="$(asdf list-all "$plugin" | grep -E '^[0-9.]+$' | tail -n 1)"

  asdf install "$plugin" "$latest_version" >/dev/null 2>&1
  asdf global "$plugin" "$latest_version" >/dev/null
done
