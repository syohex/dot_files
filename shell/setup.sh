#!/bin/sh

ln -s $PWD/zshrc ~/.zshrc

# for cdd
if [ ! -d ~/.zsh ]
then
    mkdir -p ~/.zsh
fi

CDD_PWD_FILE=$HOME/.zsh/cdd_pwd_list
if [ ! -f "$CDD_PWD_FILE" ]; then
    echo "\n" > "$CDD_PWD_FILE"
    if [ $? = 1 ]
    then
        echo "Error: Don't wrote $CDD_PWD_FILE."
        return 1
    fi
fi

# setting for GNU screen
rm -f ~/.screenrc
ln -s $PWD/screenrc ~/.screenrc
