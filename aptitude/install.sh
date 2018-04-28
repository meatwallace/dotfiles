#!/bin/bash -e

if [[ "$(uname -s)" == "Linux" ]]
then
  if ! [[ -x "$(command -v aptitude)" ]]
  then
    sudo apt-get -q -y install aptitude
  fi

  sudo aptitude -q -y update
  sudo aptitude -q -y dist-upgrade
  sudo aptitude -f -q -y install
  sudo aptitude autoclean
fi
