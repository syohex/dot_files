#!/bin/sh

set -e

PACKAGES=jslint
for package in $PACKAGES
do
    npm install -g $package
done
