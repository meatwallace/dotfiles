#!/bin/bash -e

if [[ -x "$(command -v aptitude >/dev/null 2>&1)" ]]
then
  sudo apt-get install aptitude
fi

sudo aptitude update
sudo aptitude dist-upgrade
sudo aptitude -f install
sudo aptitude autoclean