#!/bin/sh

LATEST_VERSION_PAGE="https://github.com/gohugoio/hugo/releases/latest"
LATEST_VERSION=$(
    curl -s -L "${LATEST_VERSION_PAGE}" \
    | grep -E '.*/gohugoio/hugo/releases/tag/v[0-9.]+".*' \
    | sed -E 's/.*\/gohugoio\/hugo\/releases\/tag\/v([0-9.]+)".*/\1/' \
    | head -n 1 \
    || echo ""
)

if [ -z "${LATEST_VERSION}" ]; then
    echo "cannot detect latest version automatically from page ${LATEST_VERSION_PAGE}"
    exit 1
fi

echo "Latest version: ${LATEST_VERSION}"

VERSION="${LATEST_VERSION}"
TARGET_DIR="${HOME}/Development/bin"
HUGO_DIR="hugo-${VERSION}"

if [ -d "${TARGET_DIR}/${HUGO_DIR}" ]; then
    echo "hugo ${VERSION} already exists"
    exit 1
fi

cd "${HOME}/Downloads" || exit 1

mkdir -p "${HUGO_DIR}"

PLATFORM=$(uname)

case "${PLATFORM}" in
    Darwin)
        DIST_URL="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_macOS-64bit.tar.gz"
        TARGET_DIST_FILENAME="hugo-${VERSION}.tar.gz"
        EXECUTABLE_NAME="hugo"
        ;;
    Linux)
        DIST_URL="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_Linux-64bit.tar.gz"
        TARGET_DIST_FILENAME="hugo-${VERSION}.tar.gz"
        EXECUTABLE_NAME="hugo"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        DIST_URL="https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_windows-amd64.zip"
        TARGET_DIST_FILENAME="hugo-${VERSION}.zip"
        EXECUTABLE_NAME="hugo.exe"
        ;;
    *)
        echo "unsupported platform: ${PLATFORM}"
        exit 1
        ;;
esac

echo "Downloading ${DIST_URL}"

curl -L -o "${TARGET_DIST_FILENAME}" "${DIST_URL}"

case "${TARGET_DIST_FILENAME}" in
    *.tar.gz)
        tar xfv "${TARGET_DIST_FILENAME}" --directory "${HUGO_DIR}"
        ;;
    *.zip)
        unzip -q "${TARGET_DIST_FILENAME}" -d "${HUGO_DIR}"
        ;;
    *)
        echo "unsupported archive format"
        exit 1
        ;;
esac

mkdir -p "${TARGET_DIR}"
mv "${HUGO_DIR}" "${TARGET_DIR}"

# clean up
rm -f "${TARGET_DIST_FILENAME}"

cd "${TARGET_DIR}" || exit 1

if [ -L "hugo" ]; then
    echo "delete old symlink to hugo dist..."
    rm -fv hugo
    echo "old symlink was deleted"
fi

cd "${HUGO_DIR}" || exit 1

mkdir -p bin

VERSIONED_EXECUTABLE=$(find . -type f -name "${EXECUTABLE_NAME}" | head -n 1)

if [ -z "${VERSIONED_EXECUTABLE}" ]; then
    echo "can't find hugo executable"
    exit 1
fi

ln -sf "$(pwd)/$(basename "${VERSIONED_EXECUTABLE}")" "bin/hugo"
ln -sfn "$(pwd)" ../hugo

mkdir -p "${HOME}/bin"
ln -sfn "$(pwd)" "${HOME}/bin/hugo"

echo "hugo ${VERSION} has successfully installed :-)"
