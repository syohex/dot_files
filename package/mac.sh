#!/bin/sh

set -e

# Install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

sudo brew install zsh git ispell ag coreutils
