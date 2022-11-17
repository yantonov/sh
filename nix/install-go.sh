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
SYMLINK_HOME_DIR="${HOME}/bin"
SYMLINK_HOME_PATH="${SYMLINK_HOME_DIR}/go"
SYMLINK_DEV_DIR="${INSTALL_DIR}"
SYMLINK_DEV_PATH="${SYMLINK_DEV_DIR}/go"


if [ ! -d "${INSTALL_DIR}/${GO_DIR}" ];
then
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
else
    echo "go ${VERSION} is already installed"
fi

cd "${INSTALL_DIR}"
mkdir "${SYMLINK_HOME_DIR}"
if [ -L "${SYMLINK_HOME_PATH}" ];
then
    echo "delete old symlink to go dist...";
    rm -fv "${SYMLINK_HOME_PATH}"
fi
echo "create new symlink for go dist"
ln -s "$(pwd)/go${VERSION}/bin" "${SYMLINK_HOME_PATH}"

mkdir "${SYMLINK_DEV_DIR}"
if [ -L "${SYMLINK_DEV_PATH}" ];
then
    echo "delete old symlink to go dist...";
    rm -fv "${SYMLINK_DEV_PATH}"
fi
echo "create new symlink for go dist"
ln -s "$(pwd)/go${VERSION}" "${SYMLINK_DEV_PATH}"


