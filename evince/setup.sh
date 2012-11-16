#!/bin/sh

set -e
set -x

#
# We need fonts.conf for reading Japanese PDF
#

FONTS_CONF_DIR=${HOME}/.config/fontconfig
if [ ! -d ${FONTS_CONF_DIR} ]; then
    mkdir -p $FONTS_CONF_DIR
fi

ln -sf $PWD/fonts.conf $FONTS_CONF_DIR
