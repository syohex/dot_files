#!/bin/sh

set -e
set -x

defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO

# Mission Control Animation
defaults write com.apple.dock expose-animation-duration -int 0; killall Dock
defaults write com.apple.dock expose-animation-duration -float 0.1; killall Dock

# Launchpad
defaults write com.apple.dock springboard-show-duration -int 0
defaults write com.apple.dock springboard-hide-duration -int 0
killall Dock

