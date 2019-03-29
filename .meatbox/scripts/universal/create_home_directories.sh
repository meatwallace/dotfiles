#!/usr/bin/env bash

set -euo pipefail

mkdir "$HOME"/{docs,downloads,music,pictures,projects,public,screenshots,templates,videos}

# create a symlinked desktop dir that maps to our docs, likely breaking things
ln -fs "$HOME/docs" "$HOME/desktop"
