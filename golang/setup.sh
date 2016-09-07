#!/bin/sh

set -e
set -x

go get -u github.com/github/hub
go get -u github.com/golang/lint/golint
go get -u github.com/josharian/impl
go get -u github.com/jstemmer/gotags
go get -u github.com/mitchellh/gox
go get -u github.com/motemen/ghq
go get -u github.com/motemen/gore
go get -u github.com/nsf/gocode
go get -u github.com/peco/peco/cmd/peco
go get -u github.com/rogpeppe/godef
go get -u golang.org/x/tools/cmd/cover
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/direnv/direnv
go get -u github.com/haya14busa/gopkgs/cmd/gopkgs

OS=$(uname)
if [ "x$OS" = "xLinux" -a -n "$DISPLAY" ]; then
    go get -u github.com/syohex/byzanz-window/cmd/byzanz-window
fi

# gocode configuration
gocode close
gocode set unimported-packages true
