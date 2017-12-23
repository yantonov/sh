#!/bin/sh

LATEST_VERSION_PAGE="https://github.com/gohugoio/hugo/releases/latest"
LATEST_VERSION=$(curl -s -L $LATEST_VERSION_PAGE | grep -E '.*hugo_[0-9.]+_Linux-64bit.tar.gz.*' | sed -E 's/.*hugo_([0-9.]+)_Linux-64bit.tar.gz.*/\1/' | head -n 1 || echo "")

if [ -z "${LATEST_VERSION}" ]; then
    echo "cand detect latest version automarically from page ${LATEST_VERSION_PAGE}"
    exit -1
fi

echo "Latest version: ${LATEST_VERSION}"

VERSION="${LATEST_VERSION}"
TARGET_DIR="${HOME}/Development/bin"
HUGO_DIR="hugo-${VERSION}"

if [ -d "${TARGET_DIR}/${HUGO_DIR}" ];
then
    echo "hugo ${VERSION} has already exists"
    exit 1
fi

cd "${HOME}/Downloads"
mkdir -p "${HUGO_DIR}"

PLATFORM=$(uname)
case "${PLATFORM}" in
    "Darwin")
        DIST_URL="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_macOS-64bit.tar.gz"
        ;;
    "Linux")
        DIST_URL="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz"
        ;;
    *)
        echo "invalid platform"
        exit 1
        ;;
esac

TARGET_DIST_FILENAME="hugo-${VERSION}.tar.gz"
curl -L -o "${TARGET_DIST_FILENAME}" "${DIST_URL}"
tar xfv "${TARGET_DIST_FILENAME}" --directory "${HUGO_DIR}"

EXTRACTER_DIR=$(find . -type d -name "hugo*" | head -n 1)
if [ -z "${EXTRACTER_DIR}" ]; then
    echo "cant find hugo dist"
    exit 1
fi

mkdir -p "${TARGET_DIR}"
mv "${HUGO_DIR}" "${TARGET_DIR}"

# clean up
rm "${TARGET_DIST_FILENAME}"

cd "${TARGET_DIR}"
if [ -L "hugo" ];
then
    echo "delete old symlink to hugo dist...";
    rm -fv hugo
    echo "old symlink was deleted"
fi
cd "${HUGO_DIR}"
mkdir -p bin
VERSIONED_EXECUTABLE=$(find . -type f -name "hugo*" | head -n 1)
if [ -z "${VERSIONED_EXECUTABLE}" ]; then
    echo "cant find hugo executable"
    exit 1
fi
ln -s "$(pwd)/$(basename \"${VERSIONED_EXECUTABLE})\"" "bin/hugo"
ln -s "$(pwd)" ../hugo

echo "hugo ${VERSION} has successfully installed :-)"
