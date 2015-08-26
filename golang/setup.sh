#!/bin/sh

set -e
set -x

go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/godoc
go get -u code.google.com/p/rog-go/exp/cmd/godef
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/golang/lint/golint
go get -u github.com/peco/peco/cmd/peco
go get -u github.com/jstemmer/gotags
go get -u github.com/mitchellh/gox
go get -u github.com/github/hub
go get -u github.com/motemen/gore
go get -u github.com/motemen/ghq
go get -u github.com/josharian/impl

OS=$(uname)
if [ "x$OS" = "xLinux" ]; then
    go get -u github.com/syohex/byzanz-window/cmd/byzanz-window
fi
