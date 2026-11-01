#!/usr/bin/env bash
set -eu

export URL="https://github.com/jacek-kurlit/pik.git"
export APP_NAME=pik

cd "$(dirname "$0")/rust"

make build
make install
