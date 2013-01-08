#!/bin/sh

set -e

PACKAGES=coffee-script
for package in $PACKAGES
do
    npm install -g $package
done
