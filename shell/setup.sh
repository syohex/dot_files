#!/usr/bin/env bash
set -e
set -x

# for completion file
install -d "${HOME}/.zsh/completions"

# my utilities
dev_dir="${HOME}/dev"
install -d $dev_dir/zsh

if [[ ! -d ${dev_dir}/my-command-utilities ]]; then
  (cd ${dev_dir} && git clone https://github.com/syohex/my-command-utilities.git && cd my-command-utilities && ./setup.sh)
fi

# zsh-completions
if [[ ! -d ${dev_dir}/zsh/zsh-completions ]]; then
  (cd "${dev_dir}/zsh" && git clone https://github.com/zsh-users/zsh-completions)
  ln -sf ${dev_dir}/zsh/zsh-completions ~/.zsh/
fi

# setting for zsh zaw
if [[ ! -d ${HOME}/.zsh/zaw ]]; then
  (cd "${HOME}/.zsh" && git clone https://github.com/zsh-users/zaw)
fi
