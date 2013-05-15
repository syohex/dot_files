#!/bin/sh

set -e
set -x

mkdir_if_not_exist () {
    local dir=$1
    if [ ! -d $dir ]; then
        mkdir -p $dir
    fi
}

# Emacs
mkdir_if_not_exist ~/.emacs.d
ln -sf ${PWD}/emacs/init.el ~/.emacs.d/init.el

## yasnippet
ln -sf ${PWD}/emacs/my_snippets ~/.emacs.d/my_snippets

## auto-complete dictionary
ln -sf ${PWD}/emacs/ac-dict ~/.emacs.d/ac-dict

## Use Emacs.app instead of pre-installed emacs on MacOSX
EMACS_CLIENT_APP_PATH='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
case "$OSTYPE" in
    darwin*)
        echo "Set up for MacOSX"
        ln -sf ${EMACS_CLIENT_APP_PATH} ~/bin/emacsclient
        ;;
esac

# zsh
ln -sf $PWD/shell/zshrc ~/.zshrc

# tmux
ln -sf $PWD/shell/tmux.conf ~/.tmux.conf

# aspell
ln -sf $PWD/aspell.conf ~/.aspell.conf

# fonts
mkdir_if_not_exist ~/.config/fontconfig
ln -sf $PWD/evince/fonts.conf ~/.config/fontconfig/fonts.conf

# Spellunker
ln -sf $PWD/perl/spellunker.en ~/.spellunker.en

# Python
## REPL
ln -sf $PWD/python/pythonsetup ~/.pythonsetup

## ipython
IPYTHON_DIR=${HOME}/.config/ipython/profile_default
mkdir_if_not_exist ${IPYTHON_DIR}
ln -sf $PWD/python/ipython_config.py $IPYTHON_DIR

## percol
PERCOL_DIR=~/.percol.d
mkdir_if_not_exist ${PERCOL_DIR}
ln -sf $PWD/python/percolrc.py ${PERCOL_DIR}/rc.py

# Ruby
ln -sf $PWD/ruby/pryrc ~/.pryrc

# For Common Lisp
##  CCL
ln -sf $PWD/common_lisp/ccl-init.lisp ~/.ccl-init.lisp

## CLISP
ln -sf $PWD/common_lisp/clisprc.lisp ~/.clisprc.lisp
