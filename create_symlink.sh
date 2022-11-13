#!/usr/bin/env bash
set -e
set -x

install -d ~/.config

# Emacs
install -d ~/.emacs.d
ln -sf ${PWD}/emacs/init.el ~/.emacs.d/init.el

# zsh
install -d ~/.zsh
ln -sf $PWD/shell/zshrc ~/.zshrc
ln -sf $PWD/shell/functions ~/.zsh/

# tmux
ln -sf $PWD/shell/tmux.conf ~/.tmux.conf

# aspell
ln -sf $PWD/aspell.conf ~/.aspell.conf

# SQLite
ln -sf $PWD/sql/sqliterc ~/.sqliterc

## golang
PECO_DIR=~/.config/peco
install -d ${PECO_DIR}
ln -sf $PWD/golang/config.json ${PECO_DIR}/config.json

## idea
ln -sf $PWD/idea/ideavimrc ~/.ideavimrc

## Visual Studio Code
VSCODE_USER_DIR=~/.config/Code/User
install -d ${VSCODE_USER_DIR}
ln -sf $PWD/vscode/settings.json ${VSCODE_USER_DIR}/settings.json
ln -sf $PWD/vscode/keybindings.json ${VSCODE_USER_DIR}/keybindings.json
