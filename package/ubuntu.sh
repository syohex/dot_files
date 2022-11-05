#!/bin/sh

set -e

PACKAGES="zsh tmux
    build-essential diffutils
    git
    emacs vim aspell ispell exuberant-ctags fonts-vlgothic nkf lv
    emacs-mozc emacs-mozc-bin mozc-server mozc-utils-gui
    bat exa
    curl w3m jq
    porg"

echo "Install packages:"
sudo apt install $PACKAGES
