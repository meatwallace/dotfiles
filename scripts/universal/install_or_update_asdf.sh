#!/usr/bin/env bash

set -euo pipefail

asdf_dir="$MEATBOX_LIBS_DIR/asdf"

if is not available "asdf"; then
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
  asdf update &>/dev/null
fi

declare -a plugins=(
  lua
  nodejs
  python
  ruby
)

add_or_upgrade_plugin() {
  local plugin="$1"

  if is empty "$(asdf plugin-list | grep "$plugin")"; then
    asdf plugin-add "$plugin" &>/dev/null
  else
    asdf plugin-update "$plugin" >/dev/null
  fi
}

install_and_use_latest_package_version() {
  local plugin="$1"
  local latest_version

  latest_version="$(asdf list-all "$plugin" | grep -E '^[0-9.]+$' | tail -n 1)"

  asdf install "$plugin" "$latest_version" &>/dev/null
  asdf global "$plugin" "$latest_version" >/dev/null
}

# add our version manager plugins
for plugin in "${plugins[@]}"; do
  add_or_upgrade_plugin "$plugin"
done

# import the nodejs GPG keys to verify installation
bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring" &>/dev/null

# upgrade and use the latest versions of our packages
for plugin in "${plugins[@]}"; do
  install_and_use_latest_package_version "$plugin"
done
