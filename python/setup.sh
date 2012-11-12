#!/bin/sh

set -e
set -x

# interactive python
ln -sf $PWD/pythonsetup ~/.pythonsetup

# ipython configuration file
IPYTHON_DIR=${HOME}/.config/ipython/profile_default
if [ ! -d $IPYTHON_DIR ]; then
    mkdir -p $IPYTHON_DIR
fi

ln -sf $PWD/ipython_config.py $IPYTHON_DIR
