#!/usr/bin/env bash

set -e
set -x

go get -u -v github.com/peco/peco/cmd/peco

OS=$(uname)
if [[ "x$OS" = "xLinux" -a -n "$DISPLAY" ]]; then
  go get -u -v github.com/syohex/byzanz-window/cmd/byzanz-window
fi
