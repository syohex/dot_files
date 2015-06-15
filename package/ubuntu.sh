#!/bin/sh

set -e

PACKAGES="zsh tmux
    build-essential diffutils
    git mercurial git-svn
    emacs vim aspell ispell exuberant-ctags fonts-vlgothic nkf lv
    emacs-mozc emacs-mozc-bin mozc-server mozc-utils-gui
    dia shutter byzanz handbrake
    curl w3m lftp
    minicom
    wmctrl xsel
    paco"

echo "Install packages:"
sudo apt install $PACKAGES
