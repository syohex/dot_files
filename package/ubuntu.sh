#!/usr/bin/env bash

set -e

declare -a packages
packages=(zsh build-essential diffutils vim aspell jq nkf curl w3m porg bat)

if [[ -z $WSLENV && -n $DISPLAY ]]; then
  packages+=(emacs-moz emacs-mozc-bin mozc-server mozc-utils-gui)
fi

echo "Install packages:"
sudo apt install "${packages[@]}"
