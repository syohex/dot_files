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
go get -u github.com/koron/gomigemo/cmd/migemogrep
go get -u github.com/koron/gomigemo/cmd/gmigemo
go get -u github.com/jstemmer/gotags
