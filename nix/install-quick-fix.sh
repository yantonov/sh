#!/usr/bin/env bash
set -eu

export URL="https://github.com/siedentop/git-quickfix.git"
export APP_NAME="git-quickfix"

cd "$(dirname "$0")/rust"

make build
make install
