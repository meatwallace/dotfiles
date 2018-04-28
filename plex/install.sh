#!/bin/bash

if [[ "$(uname -s)" == "Darwin" ]] && [[ ! -x "/Applications/Plex Media Server.app" ]]
then
  brew cask install plex-media-server
elif [[ "$(uname -s)" == "Linux" ]] && [[ ! -x "usr/lib/plexmediaserver" ]]
then
  # enable repository updating
  echo deb https://downloads.plex.tv/repo/deb ./public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
  curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

  sudo aptitude -q -y update
  sudo DEBIAN_FRONTEND=noninteractive aptitude -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install plexmediaserver
fi
