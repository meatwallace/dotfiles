#!/bin/bash -e

# ensure our the kitty config directory exists
mkdir -p ~/.config/kitty

# symlink our config file so that it's available to kitty
rm -f ~/.config/kitty/kitty.conf
ln -s ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

