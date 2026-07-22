#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "${HOME}/Downloads"

DEVELOPMENT_DIR="${HOME}/Development/bin"
BOOT_DIST_URL="https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh"
BOOT_EXECUTABLE="boot"
TARGET_DIRECTORY="${DEVELOPMENT_DIR}/boot/bin"
BIN_DIR="${HOME}/bin"

curl -L "${BOOT_DIST_URL}" -o "${BOOT_EXECUTABLE}"
chmod +x "${BOOT_EXECUTABLE}"
mkdir -p "${TARGET_DIRECTORY}"
mv "${BOOT_EXECUTABLE}" "${TARGET_DIRECTORY}"

mkdir -p "${BIN_DIR}"
cd "${BIN_DIR}"
ln -s "${TARGET_DIRECTORY}" boot

echo "boot has successfully installed"
