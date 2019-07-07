#!/bin/sh

set -eu

repo="jaredly/reason-language-server"

install_or_update_reason_language_server() {
  echo "reason: installing language server"

  latest="$(get-latest-github-release $repo)"
  os="$(uname -s | lowercase)"

  if [ "$os" = "darwin" ]; then
    os="macos"
  fi

  tmp_dir="$(mktemp -d)"
  output="$tmp_dir/reason-language-server.zip"

  curl -L "https://github.com/$repo/releases/download/$latest/rls-$os.zip" -o "$output"
  unzip "$output" -d "$tmp_dir"
  mv "$tmp_dir/rls-linux/reason-language-server" "$HOME/bin/reason-language-server"
  rm -rf "$tmp_dir"
}

install_or_update_reason_language_server "$@"
