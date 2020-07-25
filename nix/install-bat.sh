#!/usr/bin/env bash
set -eu

BIN_DIR="${HOME}/bin"
SOURCE_DIR="${HOME}/Development/bin"
URL="https://github.com/sharkdp/bat.git"

mkdir -p "${SOURCE_DIR}"

APP_NAME=bat

if [ -d "${APP_NAME}" ]; then
    echo "${APP_NAME} directory is already exist"
    exit 1;
fi

cd "${SOURCE_DIR}"
git clone "${URL}" "${APP_NAME}"

cd ${APP_NAME}
# for ubuntu
# apt-get install libclang-dev
cargo build --release

mkdir -p "${BIN_DIR}"
ln -s "${SOURCE_DIR}/${APP_NAME}/target/release/${APP_NAME}" "${BIN_DIR}/${APP_NAME}"
