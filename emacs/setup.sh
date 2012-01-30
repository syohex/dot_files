#!/bin/sh

# setup auto-install.el
sh $PWD/install_auto_install.sh

EC_PATH='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
case "$OSTYPE" in
darwin*)
        if [ ! -e ~/bin ]
        then
            mkdir -p ~/bin
        fi

        if [ ! -e ~/bin/emacsclient ]
        then
            ln -s ${EC_PATH} ~/bin/emacsclient
        fi
        ;;
esac

# Create symbolic link .emacs
rm -f ~/.emacs
ln -s $PWD/emacs ~/.emacs

# Create init_loader symbolic link
rm -f ~/.emacs.d/init_loader
ln -s $PWD/init_loader ~/.emacs.d/init_loader

# Create symbolic link of elisp which is managed by git
rm -f ~/.emacs.d/repos
ln -s $PWD/repos ~/.emacs.d/repos

