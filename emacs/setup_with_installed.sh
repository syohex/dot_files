#!/usr/bin/env zsh

set -e

make_install () {
    if which paco > /dev/null 2>&1; then
        sudo paco -D make install
    else
        sudo make install
    fi
}

# Emacsclient utilities
setup_emacs_server () {
    cd ~/bin

    echo "Download Emacs server utilities"

    rm -f emacs_serverstart.pl emacsclient.sh
    curl -O https://raw.github.com/syohex/emacsclient_focus/master/emacs_serverstart.pl
    curl -O https://raw.github.com/syohex/emacsclient_focus/master/emacsclient.sh
    chmod 755 emacs_serverstart.pl emacsclient.sh
}

## sdic
setup_sdic () {
    local package="sdic-2.1.3.tar.gz"

    if [ "$OSTYPE" != "linux-gnu" ]; then
        return
    fi

    cd ~/src

    echo "Setup $package"
    curl -O http://www.namazu.org/~tsuchiya/sdic/$package

    tar xf $package
    mv $package archive
    cd ${package%%.tar.gz}
    ./configure
    make
    make_install
}

## Wanderlust
setup_wanderlust () {
    echo "Setting for Wanderlust"

    for package in apel flim semi wanderlust
    do
        cd ~/src
        if [ ! -d $package ]; then
            echo "Install $package"
            git clone git://github.com/wanderlust/${package}.git
            cd $package
            make
            make_install
        else
            echo "$package is already installed!!"
        fi
    done

    cp ~/src/wanderlust/utils/ssl.el ~/.emacs.d/elisps/
    curl -o ~/.emacs.d/elisps/elscreen-wl.el 'https://raw.github.com/syohex/emacs-elscreen-wl/master/elscreen-wl.el'
}

setup_w3m () {
    cd ~/.emacs.d/elisps

    cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
    cd emacs-w3m
    autoconf
    ./configure
    make
}

for dir in ~/bin ~/src ~/.emacs.d/elisps
do
    echo "mkdir $dir"
    [ ! -d $dir ] && mkdir -p $dir
done

setup_sdic
setup_wanderlust
setup_w3m
