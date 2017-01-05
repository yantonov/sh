#!/bin/sh

VERSION="0.18.1"

cd ~/Downloads

DIST_URL="https://github.com/spf13/hugo/releases/download/v${VERSION}/hugo_${VERSION}_macOS-64bit.zip"
TARGET_DIST_FILENAME="hugo-${VERSION}.zip"
curl -L -o $TARGET_DIST_FILENAME $DIST_URL

unzip -d . $TARGET_DIST_FILENAME
extracted_dir=`find . -type d -name "hugo*" | head -n 1`
if [ -z "${extracted_dir}" ]; then
    echo "cant find hugo dist"
    exit 1
fi

TARGET_DIR=~/Development/bin
mkdir -p $TARGET_DIR

HUGO_HOME="${TARGET_DIR}/hugo-${VERSION}"

mv $extracted_dir $HUGO_HOME

# clean up
rm $TARGET_DIST_FILENAME

cd $TARGET_DIR
if [ -L "hugo" ];
then
    echo "delete old symlink to hugo dist...";
    rm -fv hugo
    echo "old symlink was deleted"
fi
cd $HUGO_HOME
ln -s `pwd` ../hugo

echo "hugo ${VERSION} has successfully installed :-)"
