#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)

cd ~/Downloads

echo "detect latest kotlin version..."
KOTLIN_VERSION=`curl -s -L https://github.com/JetBrains/kotlin/releases/latest | grep -E 'kotlin-compiler-([.0-9]+).zip' | sed -E 's/.*\/kotlin-compiler-([.0-9]+)\.zip.*/\1/' | head -n 1`
echo ""
echo "kotlin $KOTLIN_VERSION will be installed now..."
echo ""
KOTLIN_DIST_FILE_NAME="kotlin-compiler-${KOTLIN_VERSION}.zip"
KOTLIN_DIST_URL="https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip"
KOTLIN_EXTRACTED_DIR="kotlinc"
KOTLIN_DESTINATION_DIR="kotlinc-${KOTLIN_VERSION}"
INSTALL_DIR=~/Development/bin
KOTLIN_SYMLINK_NAME="kotlinc"

curl -L $KOTLIN_DIST_URL -o $KOTLIN_DIST_FILE_NAME

unzip -d . $KOTLIN_DIST_FILE_NAME

mkdir -p $INSTALL_DIR

mv $KOTLIN_EXTRACTED_DIR ~/Development/bin/$KOTLIN_DESTINATION_DIR

rm -rvi $KOTLIN_DIST_FILE_NAME

cd $INSTALL_DIR

echo "delete old symlink"
rm -rvi kotlinc
echo "create new symlink"
ln -s `pwd`/$KOTLIN_DESTINATION_DIR $KOTLIN_SYMLINK_NAME

echo "kotlin ${KOTLIN_VERSION} has successfully installed"
