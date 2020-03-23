#!/usr/bin/env bash
set -e
set -x

# for completion file
install -d "${HOME}/.zsh/completions"

# my utilities
dev_dir="${HOME}/dev"
install -d $dev_dir

if [[ -d ${dev_dir}/my-command-utilities ]]; then
    (cd ${dev_dir}/my-command-utilities && git pull --rebase origin master)
else
    (cd ${dev_dir} && git clone git@github.com:syohex/my-command-utilities.git && cd my-command-utilities && ./setup.sh)
fi

# setting for zsh zaw
if [[ -d ${HOME}/.zsh/zaw ]]; then
    (cd "${HOME}/.zsh/zaw" && git pull --rebase origin master)
else
    (cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zaw.git)
fi
## Install 3rd party zaw source
(cd "${HOME}/.zsh/zaw/sources" && curl -LO https://raw.githubusercontent.com/syohex/zaw-git-directories/master/git-directories.zsh)

# completion
if [[ -d ${HOME}/.zsh/zsh-completions ]]; then
    (cd "${HOME}/.zsh/zsh-completions" && git pull --rebase origin master)
else
    (cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zsh-completions.git)
fi
