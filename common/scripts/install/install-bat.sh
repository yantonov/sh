#!/usr/bin/env bash
set -eu

export URL="https://github.com/sharkdp/bat.git"
export APP_NAME=bat

cd "$(dirname "$0")/rust"

make build
make install
