#!/bin/sh

set -e

PACKAGES="zsh tmux
    build-essential diffutils
    git mercurial git-svn
    emacs vim aspell ispell exuberant-ctags ttf-vlgothic nkf lv
    emacs-mozc emacs-mozc-bin mozc-server mozc-utils-gui
    dia shutter byzanz handrake
    curl w3m lftp
    minicom
    wmctrl xsel
    paco sary"

if [ "x_$XDG_CURRENT_DESKTOP" = "x_XFCE" ]; then
    PACKAGES="$PACKAGES xfce-theme-manager"
fi

echo "Install packages:"
sudo apt install $PACKAGES
