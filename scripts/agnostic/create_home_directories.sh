#!/bin/sh

set -eu

create_home_directories() {
  folders="
    bin
    containers
    docs
    downloads
    music
    pictures
    projects
    public
    screenshots
    videos
    unsorted
    .zcompcache
  "

  for folder in $folders; do
    if [ ! -d "$HOME/$folder" ]; then
      mkdir "$HOME/$folder"
    fi
  done

  # create a symlinked desktop directory that maps to our docs
  ln -fs "$HOME/docs" "$HOME/desktop"
}

create_home_directories "$@"
