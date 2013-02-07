#!/bin/sh

set -e
set -x

mkdir_if_not_exist () {
    local dir = $1
    if [ ! -d $dir ]; then
        mkdir -p $dir
    fi
}

ln -sf $PWD/zshrc ~/.zshrc

# for cdd
mkdir_if_not_exist "${HOME}/.zsh/cdd"

# setting for tmux
ln -sf $PWD/tmux.conf ~/.tmux.conf

# for completion file
mkdir_if_not_exist "${HOME}/.zsh/mycomp"

# my utilities
UTILDIR="${HOME}/program/utils"
mkdir_if_not_exist $UTILDIR

cd $UTILDIR
(git clone git@github.com:syohex/my-command-utilities.git && cd my-command-utilities && ./setup.sh)

# setting for zsh zaw
(cd "${HOME}/.zsh" && git clone git@github.com:syohex/zaw.git && cd zaw && git checkout origin/syohex)

# completion
MYCOMPDIR="${HOME}/.zsh/mycomp"
curl -o $MYCOMPDIR/_perlbrew  https://raw.github.com/lapis25/dotfiles/master/.zsh/functions/_perlbrew
(cd "${HOME}/.zsh" && git://github.com/zsh-users/zsh-completions.git)
