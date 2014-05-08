#!/bin/sh

set -e

go get -u github.com/nsf/gocode
go get -u code.google.com/p/rog-go/exp/cmd/godef
go get -u code.google.com/p/go.tools/cmd/goimports
go get -u github.com/golang/lint/golint
