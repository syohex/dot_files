#!/bin/sh

AUTO_INSTALL_DIR=${HOME}/.emacs.d/auto-install

if [ ! -e $AUTO_INSTALL_DIR ]
then
    mkdir -p $AUTO_INSTALL_DIR
fi

cd $AUTO_INSTALL_DIR

if [ ! which wget > /dev/null 2>&1 ]
then
    echo "Please install wget command"
    exit 1
fi
wget http://www.emacswiki.org/emacs/download/auto-install.el

if [ "$?" -ne 0 ]
then
    echo "Can't download auto-install.el"
fi

# byte compile auto-install.el
emacs --batch -Q -f batch-byte-compile auto-install.el

# install init-loader.el
wget http://coderepos.org/share/export/38912/lang/elisp/init-loader/init-loader.el

# byte compile init-loader.el
emacs --batch -Q -f batch-byte-compile init-loader.el

if [ ! -d ~/.emacs.d/init_loader ]
then
    ln -s ~/dot_files/init_loader ~/.emacs.d
fi

# for emacsclient
if [ ! -d ~/bin ]
then
    mkdir ~/bin
fi
cd ~/bin

rm -f emacs_serverstart.pl
wget https://raw.github.com/syohex/emacsclient_focus/master/emacs_serverstart.pl
chmod 755 emacs_serverstart.pl
rm -f emacsclient.sh
wget https://raw.github.com/syohex/emacsclient_focus/master/emacsclient.sh
chmod 755 emacsclient.sh

# install snippet
cd ~/.emacs.d
if [ ! -d plugins ]
then
    mkdir -p plugins
fi

git clone syohei@59.106.183.161:git/yasnippet.git yasnippet
