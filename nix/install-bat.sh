#!/usr/bin/env bash
set -eu

BIN_DIR="${HOME}/bin"
SOURCE_DIR="${HOME}/Development/git"

mkdir -p "${SOURCE_DIR}"
cd "${SOURCE_DIR}"

if [ -d "bat" ]; then
    echo "bat directory is already exist"
    exit 1;
fi

git clone https://github.com/sharkdp/bat.git

cd bat
cargo build --release

ln -s "${SOURCE_DIR}/bat/target/release/bat" "${BIN_DIR}/bat"
