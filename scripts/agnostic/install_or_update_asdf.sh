#!/usr/bin/env bash

set -eu

install_or_update_asdf() {
  asdf_dir="$MEATBOX_LIBS_DIR/asdf"

  if ! command -v asdf; then
    echo "asdf: installing cli"

    # clone in our version manager
    git clone https://github.com/asdf-vm/asdf.git "$asdf_dir" >/dev/null

    (cd "$asdf_dir" && git checkout "$(git describe --abbrev=0 --tags)") >/dev/null

    # disable variable checking as `asdf` will blow up when we source it
    set +u

    # shellcheck source=../../libs/asdf/asdf.sh
    . "$asdf_dir/asdf.sh"

    set -u
  else
    echo "asdf: updating cli"

    asdf update >/dev/null || true
  fi

  # we skip installing plugins on alpine and simply use a node based docker image
  # to keep it simplistic unless required. known issues with plugins:
  # - dart: ?
  # - golang: requires gcc so we skip it as we're not actively developing w/ it
  # - nodejs: asdf's plugin compiles from source, so we use a nodejs base image
  if sysinfo distro | grep -q "alpine"; then
    desired_plugins=""
  else
    desired_plugins="dart golang lua nodejs python ruby"
  fi

  # add our version manager plugins
  for plugin in $desired_plugins; do
    if ! asdf list "$plugin" >/dev/null 2>&1; then
      echo "asdf: installing $plugin plugin"

      asdf plugin-add "$plugin" >/dev/null
    else
      echo "asdf: updating $plugin plugin"

      asdf plugin-update "$plugin" >/dev/null
    fi
  done

  if echo "$desired_plugins" | grep -q "nodejs"; then
    # import the nodejs GPG keys to verify installation
    bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring" >/dev/null
  fi

  # upgrade and use the latest versions of our packages
  for plugin in $desired_plugins; do
    latest_version="$(asdf list-all "$plugin" | grep -E '^[0-9.]+$' | tail -n 1)"

    echo "asdf: installing latest version of $plugin@$latest_version"

    asdf install "$plugin" "$latest_version" >/dev/null
    asdf global "$plugin" "$latest_version" >/dev/null
  done
}

install_or_update_asdf "$@"
