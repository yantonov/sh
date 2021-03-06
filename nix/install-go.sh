#!/bin/sh

PLATFORM="$(uname)"

case "${PLATFORM}" in
    Linux)
        OS="linux"
        ;;
    Darwin)
        OS="darwin"
        ;;
    *)
        echo "cant detect os automatically"
        exit 1
        ;;
esac

LATEST_VERSION=$(curl -s -L https://golang.org/dl/ | grep -E "go[0-9.]+.linux-amd64.tar.gz" | sed -E 's/.*go([0-9.]+)\.linux-amd64.tar.gz.*/\1/' | head -n 1)

ARCH="amd64"
VERSION="${LATEST_VERSION}"
INSTALL_DIR="${HOME}/Development/bin"
GO_DIR="go${VERSION}"
GO_DIST_FILENAME="go${VERSION}.${OS}-${ARCH}.tar.gz"

if [ -d "${INSTALL_DIR}/${GO_DIR}" ];
then
    echo "go ${VERSION} is already installed"
    exit 0
fi

echo "go lang ${VERSION} will be installed..."

cd "${HOME}/Downloads"
curl -O "https://storage.googleapis.com/golang/${GO_DIST_FILENAME}"
tar -xzf "${GO_DIST_FILENAME}"
# delete existing dir
TARGET="${INSTALL_DIR}/${GO_DIR}"
rm -rfv "${TARGET}"
mkdir -p "${TARGET}"
mv go/* "${TARGET}"
rmdir go
rm "${GO_DIST_FILENAME}"

cd "${INSTALL_DIR}"
if [ -L "go" ];
then
    echo "delete old symlink to go dist...";
    rm -fv go
fi
echo "create new symlink for go dist"
ln -s "$(pwd)/go${VERSION}" go
