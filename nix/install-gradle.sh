#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)
TARGET_DIR=~/Development/bin

cd ~/Downloads

echo "detect latest gradle version..."
LATEST_RELEASE_DIST_URL=`curl -s -L https://gradle.org/releases | grep -E 'https://services.gradle.org/distributions/gradle-[0-9.]+-bin.zip' | sed -E 's/.*(https:\/\/services.gradle.org\/distributions\/gradle-[0-9.]+-bin\.zip).*/\1/' | head -n 1`

if [ -z "$LATEST_RELEASE_DIST_URL" ]; then
    echo "cant find latest release url"
    exit 1
fi

VERSION=`echo $LATEST_RELEASE_DIST_URL | sed -E 's/.*-([0-9.]+)-bin\.zip/\1/' | head -n 1`

if [ -z "$VERSION" ]; then
    echo "cant detect latest version"
    exit 1
fi

DIST_FILE="gradle-$VERSION-bin.zip"
DIST_DIR="gradle-$VERSION"

if [ -d "$TARGET_DIR/$DIST_DIR" ];
then
    echo "gradle $VERSION is already exists"
    exit 1
fi

curl -L -O $LATEST_RELEASE_DIST_URL
if [ $? -ne 0 ]; then
    echo "error while downloading file"
    exit 1
fi

unzip -d . $DIST_FILE
mkdir -p $TARGET_DIR
mv $DIST_DIR $TARGET_DIR
rm $DIST_FILE

cd $TARGET_DIR
echo "delete old symlink"
rm -rvi gradle
echo "create new symlink"
ln -s `pwd`/$DIST_DIR gradle
