#!/bin/sh

xbps-install -y -S -R http://alpha.us.repo.voidlinux.org/current

xbps-install -y base-system curl darch neofetch zsh

curl --location https://github.com/bedrocklinux/bedrocklinux-userland/releases/download/0.7.6/bedrock-linux-0.7.6-x86_64.sh --output install-bedrock-linux.sh

chmod +x install-bedrock-linux.sh

./install-bedrock-linux.sh --hijack

rm install-bedrock-linux.sh
