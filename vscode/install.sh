#!/bin/bash -e

if [[ ! -x "$(command -v code-insiders)" ]]
then
  if [[ "$(uname -s)" == "Darwin" ]]
  then
    brew cask install visual-studio-code-insiders
  else
    # source
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo aptitude install code-insiders
  fi
fi
