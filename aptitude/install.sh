#!/bin/bash -e

if [[ "$(uname -s)" == "Linux" ]]
then
  if ! [[ -x "$(command -v aptitude)" ]]
  then
    sudo apt-get install aptitude
  fi

  sudo aptitude update
  sudo aptitude dist-upgrade
  sudo aptitude -f install
  sudo aptitude autoclean
fi
