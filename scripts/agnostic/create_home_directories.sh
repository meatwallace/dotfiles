#!/bin/sh

set -eu

folders="bin containers docs downloads pictures projects screenshots unsorted"

for folder in $folders; do
  if [ ! -d "$HOME/$folder" ]; then
    mkdir "$HOME/$folder"
  fi
done

# create a symlinked desktop dir that maps to our docs, likely breaking things
ln -fs "$HOME/docs" "$HOME/desktop"
