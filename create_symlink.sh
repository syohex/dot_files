#!/bin/sh

set -e
set -x

# Emacs
install -d ~/.emacs.d
ln -sf ${PWD}/emacs/init.el ~/.emacs.d/init.el
ln -sf ${PWD}/emacs/my_snippets ~/.emacs.d/
ln -sf ${PWD}/emacs/ac-dict ~/.emacs.d/
ln -sf ${PWD}/emacs/init-el-get.el ~/.emacs.d
ln -sf ${PWD}/emacs/init-loader ~/.emacs.d

## Use Emacs.app instead of pre-installed emacs on MacOSX
EMACS_CLIENT_APP_PATH='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
case "$OSTYPE" in
    darwin*)
        echo "Set up for MacOSX"
        install -d ~/bin
        ln -sf ${EMACS_CLIENT_APP_PATH} ~/bin/emacsclient
        ;;
esac

# zsh
install -d ~/.zsh
ln -sf $PWD/shell/zshrc ~/.zshrc
ln -sf $PWD/shell/functions ~/.zsh/

# tmux
ln -sf $PWD/shell/tmux.conf ~/.tmux.conf

# aspell
ln -sf $PWD/aspell.conf ~/.aspell.conf

# Spellunker
ln -sf $PWD/perl/spellunker.en ~/.spellunker.en

# Python
## REPL
install -d ~/.config
ln -sf $PWD/python/pythonsetup ~/.pythonsetup
ln -sf $PWD/python/flake8 ~/.config/flake8

## ipython
IPYTHON_DIR=${HOME}/.config/ipython/profile_default
install -d ${IPYTHON_DIR}
ln -sf $PWD/python/ipython_config.py $IPYTHON_DIR

## golang
PECO_DIR=~/.peco
install -d ${PECO_DIR}
ln -sf $PWD/golang/config.json ${PECO_DIR}/config.json

## idea
ln -sf $PWD/idea/ideavimrc ~/.ideavimrc

