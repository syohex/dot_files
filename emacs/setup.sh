#!/bin/sh

set -e
set -x

make_install () {
    if [ which paco > /dev/null 2>&1 ]
    then
        sudo paco -D make install
    else
        sudo make install
    fi
}

initialize () {
    echo -n "Checking command installed >> "
    for command in emacs git curl cvs
    do
        if [ which $command >/dev/null 2>&1 ]
        then
            echo "Please install command: $command"
            exit
        fi
    done

    echo "OK"

    # Create symbolic link .emacs
    ln -sf ~/dot_files/emacs/init.el ~/.emacs.d/init.el

    echo "Create directies"
    for dir in ~/bin ~/src ~/.emacs.d/elisps ~/program/elisp
    do
        if [ ! -d $dir ]
        then
            echo "  mkdir $dir"
            mkdir -p $dir
        fi
    done

    EC_PATH='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
    case "$OSTYPE" in
        darwin*)
            echo "Set up for MacOSX"
            if [ ! -e ~/bin/emacsclient ]
            then
                ln -sf ${EC_PATH} ~/bin/emacsclient
            fi
            ;;
    esac
}

setup_init_loader () {
    cd ~/.emacs.d/elisps

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
    ln -sf ~/dot_files/emacs/init_loader ~/.emacs.d
}

setup_theme () {
    cd ~/.emacs.d/

    echo "Setup theme"
    curl -O https://raw.github.com/syohex/emacs-reverse-theme/master/reverse-theme.el
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

## download packages manually
setup_elscreen () {
    cd ~/.emacs.d/elisps

    ## utilities of ELSCREEN
    for file in elscreen-server-0.2.0.tar.gz elscreen-wl-0.8.0.tar.gz
    do
        curl -O ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/$file
    done

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

    if [ "$OSTYPE" != "linux-gnu" ]
    then
        return
    fi

    for package in apel flim semi wanderlust
    do
        cd ~/src
        if [ ! -d $package ]
        then
            echo "Install $package"
            git clone http://git.chise.org/git/elisp/${package}.git
            cd $package
            make
            make_install
        fi
    done

    cp ~/src/wanderlust/utils/ssl.el ~/.emacs.d/elisps
}

setup_sdic () {
    local package="sdic-2.1.3.tar.gz"

    if [ "$OSTYPE" != "linux-gnu" ]
    then
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

setup_ruby () {
    local package=rsense

    cd ~/.emacs.d
    if [ ! -d rsense ]
    then
        curl -O http://cx4a.org/pub/rsense/rsense-0.3.zip
        unzip rsense-0.3.zip
        mv rsense-0.3 rsense
        rm -f rsense-0.3.zip
    fi
}

setup_python () {
    local version=`python --version 2>&1 | perl -ne 'm{(\d+\.\d+\.\d+)} and print \$1'`
    local docname="python-${version}-docs-html"

    cd ~/.emacs.d
    if [ ! -d pylookup ]
    then
        git clone https://github.com/tsgates/pylookup.git
    fi

    cd pylookup

    is_python2=`expr $version : '^2\.'`
    if [ $is_python2 != "0" ]
    then
        docurl="http://docs.python.org/archives/${docname}.zip"
    else
        docurl="http://docs.python.org/py3k/archives/${docname}.zip"
    fi

    curl -O $docurl
    unzip $docname.zip
    rm -f $docname.zip

    python pylookup.py -u $docname
}

setup_utils () {
    cd ~/program/elisp

    echo "Download my emacs utilities"
    git clone git@github.com:syohex/emacs-utils.git

    cd emacs-utils
    ./setup.sh
}

setup_misc () {
    cd ~/.emacs.d/elisps

    ## emacs w3m
    cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot login
    cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
    cd emacs-w3m
    autoconf
    ./configure
    make
    ##make_install
}

install_package () {
    cd ~/.emacs.d/elisps

    for elisp in `cat $CWD/elisp.list | grep -v '^#'`
    do
        echo "Download $elisp"
        curl -O $elisp
    done
}

## main
CWD=`pwd`

initialize
setup_init_loader
setup_theme
setup_emacs_server
setup_elscreen
setup_wanderlust
setup_sdic
setup_ruby
setup_python
setup_utils
setup_misc

install_package

## Install package
cd $CWD
emacs -Q install_elisps.el
