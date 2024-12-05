#!/usr/bin/env bash
set -e
set -x

install -d ~/.emacs.d/eshell
ln -sf $PWD/emacs/init.el ~/.emacs.d/init.el
ln -sf $PWD/emacs/alias ~/.emacs.d/eshell/alias

install -d ~/.zsh
ln -sf $PWD/shell/zshrc ~/.zshrc

ln -sf $PWD/shell/tmux.conf ~/.tmux.conf

ln -sf $PWD/aspell.conf ~/.aspell.conf

ln -sf $PWD/sql/sqliterc ~/.sqliterc

PECO_DIR=~/.config/peco
install -d ${PECO_DIR}
ln -sf $PWD/golang/config.json ${PECO_DIR}/config.json

if [[ -z $WSLENV ]]; then
  ln -sf $PWD/idea/ideavimrc ~/.ideavimrc

  VSCODE_USER_DIR=~/.config/Code/User
  install -d ${VSCODE_USER_DIR}
  ln -sf $PWD/vscode/settings.json ${VSCODE_USER_DIR}/settings.json
  ln -sf $PWD/vscode/keybindings.json ${VSCODE_USER_DIR}/keybindings.json
fi
