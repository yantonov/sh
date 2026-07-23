#!/usr/bin/env bash
set -eu

export URL="https://github.com/BurntSushi/ripgrep.git"
export APP_NAME=rg

cd "$(dirname "$0")/rust"

make build
make install
