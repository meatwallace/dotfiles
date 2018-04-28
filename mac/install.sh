#!/bin/bash -e

# update app store installs
if [[ "$(uname -s)" == "Darwin" ]]
then
  sudo softwareupdate -i -a
fi
