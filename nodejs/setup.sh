#!/bin/sh
set -e

PACKAGES="jslint coffee-script"
for package in $PACKAGES
do
    npm install -g $package
done
