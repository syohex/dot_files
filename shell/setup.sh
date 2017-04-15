#!/bin/sh

set -e
set -x

# for completion file
install -d "${HOME}/.zsh/mycomp"

# my utilities
UTILDIR="${HOME}/program/utils"
install -d $UTILDIR

cd $UTILDIR
(git clone git@github.com:syohex/my-command-utilities.git && cd my-command-utilities && ./setup.sh)

# setting for zsh zaw
(cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zaw.git)
## Install 3rd party zaw source
(cd "${HOME}/.zsh/zaw/sources" && curl -O https://raw.github.com/syohex/zaw-git-directories/master/git-directories.zsh )
(cd "${HOME}/.zsh/zaw/sources" && curl -O https://raw.github.com/shibayu36/config-file/master/.zsh/zaw-sources/git-recent-branches.zsh)

# completion
MYCOMPDIR="${HOME}/.zsh/mycomp"
(cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zsh-completions.git)
