#!/bin/sh

if [ ! -d ~/.emacs.d ]
then
    mkdir ~/.emacs.d
fi

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
INIT_FILE=~/.emacs.d/init.el
rm -f $INIT_FILE
ln -s $PWD/emacs $INIT_FILE

# Create init_loader symbolic link
rm -f ~/.emacs.d/init_loader
ln -s $PWD/init_loader ~/.emacs.d/init_loader
