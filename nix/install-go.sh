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

LATEST_VERSION=`curl -s -L https://golang.org/dl/ | grep -E "go[0-9.]+.linux-amd64.tar.gz" | sed -E 's/.*go([0-9.]+)\.linux-amd64.tar.gz.*/\1/' | head -n 1`

ARCH="amd64"
VERSION=$LATEST_VERSION
INSTALL_DIR=$HOME/Development/bin
GO_DIR=go$VERSION
GO_DIST_FILENAME="go$VERSION.$OS-$ARCH.tar.gz"

echo "go lang $VERSION will be installed..."

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
if [ -L "go" ];
then
    echo "delete old symlink to go dist...";
    rm -fv go
fi
echo "create new symlink for go dist"
ln -s `pwd`/go$VERSION go
