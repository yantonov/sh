#!/usr/bin/env bash
set -eu

TARGET="${HOME}/bin/mill"

curl -L https://github.com/lihaoyi/mill/releases/download/0.8.0/0.8.0 \
     -o "${TARGET}"

chmod +x "${TARGET}"

echo "Mill is installed to: ${TARGET}"
