#!/bin/sh

# Must need 'aptitude'
if [ ! which aptitude > /dev/null 2>&1 ]
then
    echo "Please install 'aptitude'"
    exit
fi

PACKAGES= zsh git emacs vim subversion \
          emacs-mozc emacs-mozc-bin ibus-mozc mozc-server mozc-utils-gui \
          dia diffutils

echo "Install packages:"
sudo aptitude install $PACKAGES
