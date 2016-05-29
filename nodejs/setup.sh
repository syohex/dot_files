#!/bin/sh
set -e

PACKAGES="jslint coffee-script tern"
for package in $PACKAGES
do
    npm install -g $package
done
