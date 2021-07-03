#!/usr/bin/env bash
set -eu

export URL="https://github.com/starship/starship.git"
export APP_NAME=starship

cd "$(dirname "$0")/rust"

make build
make install
