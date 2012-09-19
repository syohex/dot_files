#!/bin/sh

# ack configuration file
ln -sf $PWD/ackrc ~/.ackrc

# clone my_pmsetup
PERLDIR="${HOME}/program/perl"
if [ -d $PERLDIR ]
then
    mkdir $PERLDIR
fi

cd $PERLDIR
git clone git@github.com:syohex/my-pmsetup.git
