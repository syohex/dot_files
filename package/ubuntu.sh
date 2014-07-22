#!/bin/sh

set -e

PACKAGES="zsh git-svn emacs vim subversion build-essential
    emacs-mozc emacs-mozc-bin mozc-server mozc-utils-gui
    dia diffutils nkf lv w3m gtk-recordmydesktop
    curl shutter lftp aspell ispell minicom ttf-vlgothic
    wmctrl paco tmux sary xsel exuberant-ctags"

if [ "x_$XDG_CURRENT_DESKTOP" = "x_XFCE" ]; then
    PACKAGES="$PACKAGES xfce-theme-manager"
fi

echo "Install packages:"
sudo apt install $PACKAGES
