#!/bin/sh

ln -sf $PWD/zshrc ~/.zshrc

# for cdd
if [ ! -d ~/.zsh/cdd ]
then
    mkdir -p ~/.zsh/cdd
fi

# setting for GNU screen
ln -sf $PWD/screenrc ~/.screenrc

# setting for tmux
ln -sf $PWD/tmux.conf ~/.tmux.conf

# for completion file
COMPDIR=~/.zsh/mycomp
if [ ! -d $COMPDIR ]
then
    mkdir -p $COMPDIR
fi

# setting for zsh zaw
(cd ~/.zsh && git clone git@github.com:syohex/zaw.git && cd zaw && git checkout origin/syohex)

curl -o $COMPDIR/_perlbrew  https://raw.github.com/lapis25/dotfiles/master/.zsh/functions/_perlbrew
curl -o $COMPDIR/_gisty https://raw.github.com/swdyh/gisty/master/_gisty
