#!/bin/sh

ELASTIC_VERSION="2.2.0"

INSTALL_DIR="$HOME/Development/bin"
TARGET_DIR="elastic-$ELASTIC_VERSION"

DIST_URL="https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/$ELASTIC_VERSION/elasticsearch-$ELASTIC_VERSION.zip"

PACKAGE_FILENAME="elasticsearch-$ELASTIC_VERSION.zip"

if [ -d "$INSTALL_DIR/$TARGET_DIR" ];
then
    echo "elastic $ELASTIC_VERSION is already installed"
else
    cd $HOME/Downloads
    # download
    curl -L -o $PACKAGE_FILENAME $DIST_URL
    # extract to install dir
    unzip -d $INSTALL_DIR/$TARGET_DIR $PACKAGE_FILENAME
    # reduce dir depth
    mv $INSTALL_DIR/$TARGET_DIR/elasticsearch-$ELASTIC_VERSION/* $INSTALL_DIR/$TARGET_DIR
    rmdir $INSTALL_DIR/$TARGET_DIR/elasticsearch-$ELASTIC_VERSION
    # cleanup downloaded files
    rm $PACKAGE_FILENAME
    cd $INSTALL_DIR
    # remove old sym link
    if [ -L "elastic" ];
    then
        echo "removing old symlink to elastic dist"
        rm -iv elastic
    fi
    # create symlink
    ln -s $INSTALL_DIR/$TARGET_DIR elastic
fi


