#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)

cd ~/Downloads

INSTALL_DIR=~/Development/bin
BOOT_DIST_URL="https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh"
BOOT_EXECUTABLE="boot"
TARGET_DIRECTORY="$INSTALL_DIR/boot/bin"

curl -L $BOOT_DIST_URL -o $BOOT_EXECUTABLE

chmod +x $BOOT_EXECUTABLE

mkdir -p $TARGET_DIRECTORY

mv $BOOT_EXECUTABLE $TARGET_DIRECTORY

echo "boot has successfully installed"
