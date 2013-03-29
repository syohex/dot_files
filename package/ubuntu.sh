#!/bin/sh

set -e

PACKAGES= zsh git-svn emacs vim subversion build-essential \
    emacs-mozc emacs-mozc-bin ibus-mozc mozc-server mozc-utils-gui \
    dia diffutils nkf lv cvs cvs-utils w3m gtk-recordmydesktop \
    shutter lftp aspell ispell minicom

echo "Install packages:"
sudo aptitude install $PACKAGES
