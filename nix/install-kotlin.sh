#!/bin/sh

cd ~/Downloads

echo "detect latest kotlin version..."
VERSION=$(curl -s -L https://github.com/JetBrains/kotlin/releases/latest | grep -E 'kotlin-compiler-([-_.0-9]+).zip' | sed -E 's/.*\/kotlin-compiler-([-_.0-9]+)\.zip.*/\1/' | head -n 1)

if [ -z "${VERSION}" ]; then
    echo "cant detect kotlin latest version"
    exit 1
fi

echo "latest version is: $VERSION"


KOTLIN_DIST_FILE_NAME="kotlin-compiler-${VERSION}.zip"
KOTLIN_DIST_URL="https://github.com/JetBrains/kotlin/releases/download/v${VERSION}/kotlin-compiler-${VERSION}.zip"
KOTLIN_EXTRACTED_DIR="kotlinc"
KOTLIN_DESTINATION_DIR="kotlinc-${VERSION}"
INSTALL_DIR=~/Development/bin
BIN_DIR=~/bin
KOTLIN_SYMLINK_NAME="kotlinc"

if [ -d "${INSTALL_DIR}/${KOTLIN_DESTINATION_DIR}" ];
then
    echo "kotlin ${VERSION} is already installed"
    exit 0
fi

echo ""
echo "kotlin ${VERSION} will be installed now..."
echo ""

curl -L "${KOTLIN_DIST_URL}" -o "${KOTLIN_DIST_FILE_NAME}"

if [ $? -ne 0 ]; then
    echo "cant download distributive"
    exit 1
fi

unzip -d . "${KOTLIN_DIST_FILE_NAME}"

mkdir -p "${INSTALL_DIR}"

mv "${KOTLIN_EXTRACTED_DIR}" "${HOME}/Development/bin/${KOTLIN_DESTINATION_DIR}"

rm -r "${KOTLIN_DIST_FILE_NAME}"

cd "${BIN_DIR}"

if [ -L "${KOTLIN_SYMLINK_NAME}" ]; then
    rm -rv kotlinc
fi
ln -s "$INSTALL_DIR/${KOTLIN_DESTINATION_DIR}" "${KOTLIN_SYMLINK_NAME}"

echo "kotlin ${VERSION} has successfully installed"
