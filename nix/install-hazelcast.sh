#!/bin/sh

cd ~/Downloads

SOURCE_URL_PATTERN="http://download.hazelcast.com/code-samples/hazelcast-code-samples-([0-9]+(\.[0-9])*).zip"
ESCAPED_URL=`/bin/echo -n $SOURCE_URL_PATTERN | sed -E 's/\//\\\\\//g'`
SED_SOURCE_URL_PATTERN="s/.*$ESCAPED_URL.*/\1/"

DOWNLOAD_PAGE=`curl -L "https://hazelcast.org/download/"`

VERSION=`echo $DOWNLOAD_PAGE | grep -E $SOURCE_URL_PATTERN | sed -E $SED_SOURCE_URL_PATTERN | head -n 1`

echo "Try install hazelcast $VERSION ..."

TARGET_DIR=~/Development/bin

if [ -d "$TARGET_DIR/hazelcast-$VERSION" ]; then
    echo "Hazelast $VERSION is already installed"
    exit 1
else
    DOWNLOAD_HAZELCAST_ZIP_PATTERN="http://download.hazelcast.com/download.jsp\?version=hazelcast-$VERSION&p="
    ESCAPED_URL=`/bin/echo -n $DOWNLOAD_HAZELCAST_ZIP_PATTERN | sed -E 's/\//\\\\\//g'`
    SED_DOWNLOAD_HAZELCAST_URL_PATTERN="s/.*($ESCAPED_URL).*/\1/"

    DOWNLOAD_URL=`echo $DOWNLOAD_PAGE | grep -E $DOWNLOAD_HAZELCAST_ZIP_PATTERN | sed -E $SED_DOWNLOAD_HAZELCAST_URL_PATTERN | head -n 1`
    DIST_FILE_NAME="hazelcast-$VERSION.zip"
    curl -L -o $DIST_FILE_NAME $DOWNLOAD_URL

    unzip -d . $DIST_FILE_NAME

    HAZELCAST_DISTR=`ls -1d */ | cut -f1 -d'/'`

    mkdir -p $TARGET_DIR

    mv $HAZELCAST_DISTR $TARGET_DIR

    rm $DIST_FILE_NAME
    if [ -L "$TARGET_DIR/hazelcast" ]; then
        rm -fv $TARGET_DIR/hazelcast
    fi
    ln -s $TARGET_DIR/$HAZELCAST_DISTR $TARGET_DIR/hazelcast
fi


