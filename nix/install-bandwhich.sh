#!/usr/bin/env bash
set -eu

export URL="https://github.com/imsnif/bandwhich.git"
export APP_NAME=bandwhich

cd "$(dirname "$0")/rust"

make build
make install
