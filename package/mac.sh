#!/bin/sh

set -e

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

brew install zsh git
