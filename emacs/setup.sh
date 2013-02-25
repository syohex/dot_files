#!/bin/sh

set -e
set -x

## main
CWD=`pwd`

initialize

if [ "$@" = "" ]; then
    echo "Error: no specified target"
    exit
fi

for target in $@
do
    setup_func=setup_${target}
    if type $setup_func 1>/dev/null 2>/dev/null
    then
        setup_func
    else
        echo "Error undefined function '$testname'"
    fi
done

## Install package
cd $CWD
emacs -Q install_elisps.el
