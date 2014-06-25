#!/bin/sh

set -e
set -x

go get -u github.com/nsf/gocode
go get -u code.google.com/p/rog-go/exp/cmd/godef
go get -u code.google.com/p/go.tools/cmd/goimports
go get -u github.com/golang/lint/golint
go get -u github.com/peco/peco/cmd/peco/
go get -u github.com/syohex/gotentry
go get -u github.com/motemen/ghq
