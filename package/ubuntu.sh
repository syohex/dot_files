#!/usr/bin/env bash

set -e

declare -a packages
packages=(zsh build-essential diffutils vim aspell jq nkf curl bat ripgrep)

echo "Install packages:"
sudo apt install "${packages[@]}"
