#!/bin/sh

set -e
set -x

mkdir_if_not_exist () {
    local dir=$1
    if [ ! -d $dir ]; then
        mkdir -p $dir
    fi
}

# for completion file
mkdir_if_not_exist "${HOME}/.zsh/mycomp"

# my utilities
UTILDIR="${HOME}/program/utils"
mkdir_if_not_exist $UTILDIR

cd $UTILDIR
(git clone git@github.com:syohex/my-command-utilities.git && cd my-command-utilities && ./setup.sh)

# setting for zsh zaw
(cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zaw.git)
## Install 3rd party zaw source
(cd "${HOME}/.zsh/zaw/sources" && curl -O https://raw.github.com/syohex/zaw-git-directories/master/git-directories.zsh \)
(cd "${HOME}/.zsh/zaw/sources" && curl -O https://raw.github.com/shibayu36/config-file/master/.zsh/zaw-sources/git-recent-branches.zsh)

# completion
MYCOMPDIR="${HOME}/.zsh/mycomp"
(cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zsh-completions.git)
