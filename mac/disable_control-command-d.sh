#!/bin/sh
set -e

## Disable Control-Command-D for Emacs
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

echo "*** System restart required ***"
