#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <platform>"
    echo "\twhere platform = mac | linux"
    exit 0
fi

PLATFORM=$1

SCRIPT_DIR=$(cd `dirname $0` && pwd)

VERSION="2.1.1"
DIST_ROOT_URL="https://bitbucket.org/ariya/phantomjs/downloads"
TARGET_DIR=~/Development/bin/
TARGET_PHANTOMJS_DIR="phantomjs-${VERSION}"

if [ "${PLATFORM}" = "mac" ]; then
    ARCHITECTURE="macosx"
    DIST_FILE_NAME="phantomjs-2.1.1-${ARCHITECTURE}.zip"
    EXTRACT_ARCHIVE_COMMAND="unzip -d . "
fi

if [ "${PLATFORM}" = "linux" ]; then
    ARCHITECTURE="linux-x86_64"
    DIST_FILE_NAME="phantomjs-2.1.1-${ARCHITECTURE}.tar.bz2"
    EXTRACT_ARCHIVE_COMMAND="tar xvf "
fi

if [ -z "${ARCHITECTURE}" ]; then
    echo "invalid platform: ${PLATFORM} (known platforms mac, linux)"
    exit 1
fi

DIST_URL="${DIST_ROOT_URL}/${DIST_FILE_NAME}"

cd ~/Downloads
curl -L -o $DIST_FILE_NAME $DIST_URL

$EXTRACT_ARCHIVE_COMMAND $DIST_FILE_NAME
EXTRACTED_DIR="phantomjs-2.1.1-${ARCHITECTURE}"
mv $EXTRACTED_DIR $TARGET_DIR/$TARGET_PHANTOMJS_DIR
# clean up
rm $DIST_FILE_NAME

# create symlink
mkdir -p $TARGET_DIR
cd $TARGET_DIR
SYMLINK_NAME="phantomjs"
if [ -d "${SYMLINK_NAME}" ]; then
    echo "delete old sym link:"
    rm -ri ${SYMLINK_NAME}
    ln -s `pwd`/$TARGET_PHANTOMJS_DIR $SYMLINK_NAME
fi

echo "phantomjs ${VERSION} has successfully installed"
