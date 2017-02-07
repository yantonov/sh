#!/bin/sh

VERSION="0.18.1"
TARGET_DIR=~/Development/bin
HUGO_DIR="hugo-${VERSION}"

if [ -d "${TARGET_DIR}/${HUGO_DIR}" ];
then
    echo "hugo ${VERSION} has already exists"
    exit 1
fi

if [ $# -eq 0 ]; then
    scr=`basename $0`
    echo "Usage:"
    echo "${scr} mac|linux - install to given platform"
    echo "${scr} - show this help"
    exit 0
fi

cd ~/Downloads

PLATFORM=$1

case "$PLATFORM" in
    "mac")
        DIST_URL="https://github.com/spf13/hugo/releases/download/v${VERSION}/hugo_${VERSION}_macOS-64bit.zip"
        TARGET_DIST_FILENAME="hugo-${VERSION}.zip"
        curl -L -o $TARGET_DIST_FILENAME $DIST_URL

        unzip -d . $TARGET_DIST_FILENAME

        ;;
    "linux")
        DIST_URL="https://github.com/spf13/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz"
        TARGET_DIST_FILENAME="hugo-${VERSION}.tar.gz"
        curl -L -o $TARGET_DIST_FILENAME $DIST_URL

        tar xfv $TARGET_DIST_FILENAME
        ;;
    *)
        echo "invalid platform"
        exit 1
        ;;
esac

extracted_dir=`find . -type d -name "hugo*" | head -n 1`
if [ -z "${extracted_dir}" ]; then
    echo "cant find hugo dist"
    exit 1
fi

mv `basename $extracted_dir` $HUGO_DIR

mkdir -p $TARGET_DIR
mv $HUGO_DIR $TARGET_DIR

# clean up
rm $TARGET_DIST_FILENAME

cd $TARGET_DIR
if [ -L "hugo" ];
then
    echo "delete old symlink to hugo dist...";
    rm -fv hugo
    echo "old symlink was deleted"
fi
cd $HUGO_DIR
mkdir -p bin
versioned_executable=`find . -type f -name "hugo*" | head -n 1`
if [ -z "$versioned_executable" ]; then
    echo "cant find hugo executable"
    exit 1
fi
ln -s `pwd`/`basename $versioned_executable` bin/hugo
ln -s `pwd` ../hugo

echo "hugo ${VERSION} has successfully installed :-)"
