#!/usr/bin/env bash
set -eu

export URL="https://github.com/ClementTsang/bottom.git"
export APP_NAME=bottom
export EXECUTABLE_NAME="btm"

cd "$(dirname "$0")/rust"

make build
make install
