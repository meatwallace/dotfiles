#!/bin/sh

set -eu

version="0.10.3"
kernel="$(uname -s | lowercase)"
url="https://github.com/wtfutil/wtf/releases/download/v${version}/wtf_${version}_${kernel}_amd64.tar.gz"
tmpdir="$(mktemp -d)"


# sudo curl -L "$url" | sudo tar -C /usr/local/bin --strip-components=1 -zxf - wtf
curl -L "$url" | tar -C "$tmpdir" --strip-components=1 -zxf -
sudo cp "$tmpdir/wtf" /usr/local/bin

rm -rf "$tmpdir"
