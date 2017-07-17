#!/bin/bash -e

####################
# set mac defaults #
####################

# disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# open everything in finder's list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# show the ~/Library folder
chflags nohidden ~/Library

# set a fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# set the Finder prefs for showing a few different volumes on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# hide Safari's bookmark bar
defaults write com.apple.Safari ShowFavoritesBar -bool false

# set up Safari for dev
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true