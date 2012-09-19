#!/bin/sh

set -e
set -x

mkdir_if_not_exist () {
    local dir = $1
    if [ ! -d $dir ]
    then
        mkdir $dir
    fi
}

ln -sf $PWD/zshrc ~/.zshrc

# for cdd
mkdir_if_not_exist "${HOME}/.zsh/cdd"

# setting for GNU screen
ln -sf $PWD/screenrc ~/.screenrc

# setting for tmux
ln -sf $PWD/tmux.conf ~/.tmux.conf

# for completion file
mkdir_if_not_exist "${HOME}/.zsh/mycomp"

# my utilities
UTILDIR="${HOME}/program/utils"
mkdir_if_not_exist $UTILDIR

cd $UTILDIR
git clone git@github.com:syohex/my-command-utilities.git
cd my-command-utilities
./setup.sh

# setting for zsh zaw
(cd ~/.zsh && git clone git@github.com:syohex/zaw.git && cd zaw && git checkout origin/syohex)

curl -o $COMPDIR/_perlbrew  https://raw.github.com/lapis25/dotfiles/master/.zsh/functions/_perlbrew
curl -o $COMPDIR/_gisty https://raw.github.com/swdyh/gisty/master/_gisty
