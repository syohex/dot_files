#!/bin/sh

set -e

PACKAGES=zsh git-svn emacs vim subversion build-essential \
    emacs-mozc emacs-mozc-bin ibus-mozc mozc-server mozc-utils-gui \
    dia diffutils nkf lv cvs cvsutils w3m gtk-recordmydesktop \
    curl shutter lftp aspell ispell minicom ttf-vlgothic \
    wmctrl paco tmux sary xsel

echo "Install packages:"
sudo aptitude install $PACKAGES
