#!/usr/bin/env bash
set -eu

export URL="https://github.com/dandavison/delta"
export APP_NAME=delta

cd "$(dirname "$0")/rust"

make build
make install
