#!/bin/bash -e

# install
if [[ "$(uname -s)" == "Darwin" ]] && [[ ! -x "/Applications/Visual Studio Code - Insiders.app" ]]
then
  brew cask install visual-studio-code-insiders
elif [[ "$(uname -s)" == "Linux" ]] && [[ ! -x "$(command -v code-insiders)" ]]
then
  # source
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

  sudo aptitude -q -y install code-insiders
fi

# set installation directory
if [[ "$(uname -s)" == "Darwin" ]]
then
  VSCODE="${HOME}"/Library/Application\ Support/Code\ -\ Insiders/User
elif [[ "$(uname -s)" == "Linux" ]]
then
  VSCODE="${HOME}"/.config/Code\ -\ Insiders/User
fi

# if this is our first run, the folder wont exist
if [[ ! -d "$VSCODE" ]]; then
  mkdir -p "$VSCODE"
fi

# symlink dotfiles
rm -f "${VSCODE}/projects.json"
rm -f "${VSCODE}/settings.json"
rm -f "${VSCODE}/keybindings.json"
rm -rf "${VSCODE}/snippets"

ln -s "${ZSH}/vscode/projects.json" "${VSCODE}/projects.json"
ln -s "${ZSH}/vscode/settings.json" "${VSCODE}/settings.json"
ln -s "${ZSH}/vscode/keybindings.json" "${VSCODE}/keybindings.json"
ln -s "${ZSH}/vscode/snippets" "${VSCODE}/snippets"
