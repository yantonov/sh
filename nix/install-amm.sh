#!/usr/bin/env bash
set -eu

TARGET="${HOME}/bin/amm"

curl -L https://github.com/lihaoyi/Ammonite/releases/download/2.2.0/2.13-2.2.0 \
     -o "${TARGET}"

chmod +x "${TARGET}"
