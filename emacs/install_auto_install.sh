#!/bin/sh

set -e

initialize () {
    echo -n "Checking command installed >> "
    for command in emacs git curl paco
    do
        if [ which $command >/dev/null 2>&1 ]
        then
            echo "Please install command: $command"
            exit
        fi
    done

    echo "OK"

    echo "Create directies"
    for dir in ~/.emacs.d/auto-install ~/bin ~/emacs.d/elisps ~/src
    do
        if [ ! -d $dir ]
        then
            echo "  mkdir $dir"
            mkdir -p $dir
        fi
    done
}

setup_auto_install () {
    cd ~/.emacs.d/auto-install

    echo "Setup auto-install.el"

    ##  init-loader.el
    if [ -e auto-install.el ]
    then
        rm -f auto-install.el
    fi

    echo "Install auto-install.el"
    curl -O http://www.emacswiki.org/emacs/download/auto-install.el

    if [ "$?" -ne 0 ]
    then
        echo "Can't download auto-install.el"
    fi

    # byte compile auto-install.el
    emacs --batch -Q -f batch-byte-compile auto-install.el
}

setup_init_loader () {
    cd ~/.emacs.d/auto-install

    echo "Setup init-loader.el"

    ##  init-loader.el
    if [ -e init-loader.el]
    then
        rm -f init-loader.el
    fi

    echo "Install init-loader.el"
    curl -O https://raw.github.com/gist/1021706/b9aff51e7e40afa7abb3c7d6ef7708993ad93b04/init-loader.el

    # byte compile init-loader.el
    emacs --batch -Q -f batch-byte-compile init-loader.el

    echo "Create symlink ~/dot_files/init_loader ==> ~/.emacs.d "
    ln -sf ~/dot_files/init_loader ~/.emacs.d
}

# Emacsclient utilities
setup_emacs_server () {
    cd ~/bin

    echo "Download Emacs server utilities"

    rm -f emacs_serverstart.pl emacsclient.sh
    curl -O https://raw.github.com/syohex/emacsclient_focus/master/emacs_serverstart.pl \
            https://raw.github.com/syohex/emacsclient_focus/master/emacsclient.sh
    chmod 755 emacs_serverstart.pl emacsclient.sh
}

## download packages manually
setup_elscreen () {
    cd ~/.emacs.d/elisps

    ## utilities of ELSCREEN
    curl -O ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/elscreen-server-0.2.0.tar.gz \
            ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/elscreen-wl-0.8.0.tar.gz

    tar xvf elscreen-server-0.2.0.tar.gz
    mv elscreen-server-0.2.0/*.el .

    tar xvf elscreen-wl-0.8.0.tar.gz
    mv elscreen-wl-0.8.0/*.el .

    rm -rf elscreen-server-0.2.0.tar.gz elscreen-server-0.2.0 \
           elscreen-wl-0.8.0.tar.gz elscreen-wl-0.8.0
}

## Wanderlust
setup_wanderlust () {
    echo "Setting for Wanderlust"

    cd ~/src

    for package in apel flim semi wanderlust
    do
        if [ ! -d $package ]
        then
            echo "Install $package"
            git clone http://git.chise.org/git/elisp/${package}.git
            (cd $package && make && sudo paco -D make install)
        fi
    done

    cp wanderlust/utils/ssl.el ~/.emacs.d/elisps
}

setup_sdic () {
    local package=sdic-2.1.3.tar.gz

    cd ~/src

    echo "Setup $package"
    curl -O http://www.namazu.org/~tsuchiya/sdic/$package

    tar xf $package
    (cd ${package%%.tar.gz} && make && sudo paco -D make install)
}

setup_misc () {
    cd ~/src

    ## slime
    git clone https://github.com/nablaone/slime.git
}

## main
initialize
setup_auto_install
setup_init_loader
setup_emacs_server
setup_elscreen
setup_wanderlust
setup_sdic
setup_misc
