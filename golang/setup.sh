#!/bin/sh

set -e
set -x

go get -u -v github.com/github/hub
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/josharian/impl
go get -u -v github.com/jstemmer/gotags
go get -u -v github.com/zmb3/gogetdoc
go get -u -v github.com/mitchellh/gox
go get -u -v github.com/motemen/ghq
go get -u -v github.com/motemen/gore
go get -u -v github.com/nsf/gocode
go get -u -v github.com/peco/peco/cmd/peco
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/cover
go get -u -v golang.org/x/tools/cmd/godoc
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v github.com/direnv/direnv
go get -u -v github.com/haya14busa/gopkgs/cmd/gopkgs
go get -u -v github.com/derekparker/delve/cmd/dlv
go get -u -v github.com/fatih/gomodifytags

OS=$(uname)
if [ "x$OS" = "xLinux" -a -n "$DISPLAY" ]; then
    go get -u -v github.com/syohex/byzanz-window/cmd/byzanz-window
fi

# gocode configuration
gocode close
gocode set unimported-packages true
