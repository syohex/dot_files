#!/bin/sh
set -e
set -x

# completion, definition jump
cargo install racer

# code formatter
cargo install rustfmt
