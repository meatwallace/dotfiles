#!/bin/bash -e

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
rm -f "${VSCODE}/settings.json"
rm -f "${VSCODE}/keybindings.json"
rm -rf "${VSCODE}/snippets"

ln -s "${ZSH}/vscode/settings.json" "${VSCODE}/settings.json"
ln -s "${ZSH}/vscode/keybindings.json" "${VSCODE}/keybindings.json"
ln -s "${ZSH}/vscode/snippets" "${VSCODE}/snippets"
