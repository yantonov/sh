#!/bin/sh

case "$1" in
    linux)
        OS="linux"
        ;;
    mac)
        OS="darwin"
        ;;
    *)
        echo "install-go.sh <os>"
        echo "\twhere - os - linux | mac"
        exit 0
        ;;
esac

ARCH="amd64"
VERSION="1.5.3"
INSTALL_DIR=$HOME/Development/bin
GO_DIR=go$VERSION
GO_DIST_FILENAME="go$VERSION.$OS-$ARCH.tar.gz"

cd ~/Downloads
curl -O https://storage.googleapis.com/golang/$GO_DIST_FILENAME
tar -xzf $GO_DIST_FILENAME
# delete existing dir
rm -rfv $INSTALL_DIR/$GO_DIR
mkdir -p $INSTALL_DIR/$GO_DIR
mv go/* $INSTALL_DIR/$GO_DIR
rmdir go
rm $GO_DIST_FILENAME

cd $INSTALL_DIR
if [ -f "go" ];
then
    echo "delete old symlink to go dist...";
    rm -fv go
fi
ln -s `pwd`/go$VERSION go
