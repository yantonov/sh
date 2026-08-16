#!/usr/bin/env bash
set -eu

REPO="Wilfred/difftastic"
TARGET_DIR="${HOME}/.local/bin"

PLATFORM="$(uname)"
ARCH="$(uname -m)"

case "${PLATFORM}" in
    Linux)
        EXECUTABLE_NAME="difft"
        UNPACK_COMMAND="tar xzf"
        case "${ARCH}" in
            x86_64)
                ASSET="difft-x86_64-unknown-linux-musl.tar.gz"
                ;;
            aarch64|arm64)
                ASSET="difft-aarch64-unknown-linux-gnu.tar.gz"
                ;;
            *)
                echo "unsupported architecture: ${ARCH}"
                exit 1
                ;;
        esac
        ;;
    Darwin)
        EXECUTABLE_NAME="difft"
        UNPACK_COMMAND="tar xzf"
        case "${ARCH}" in
            x86_64)
                ASSET="difft-x86_64-apple-darwin.tar.gz"
                ;;
            arm64|aarch64)
                ASSET="difft-aarch64-apple-darwin.tar.gz"
                ;;
            *)
                echo "unsupported architecture: ${ARCH}"
                exit 1
                ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        EXECUTABLE_NAME="difft.exe"
        UNPACK_COMMAND="unzip -o"
        case "${ARCH}" in
            x86_64)
                ASSET="difft-x86_64-pc-windows-msvc.zip"
                ;;
            aarch64|arm64)
                ASSET="difft-aarch64-pc-windows-msvc.zip"
                ;;
            *)
                echo "unsupported architecture: ${ARCH}"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "cant detect os automatically: ${PLATFORM}"
        exit 1
        ;;
esac

echo "Detecting latest difftastic release..."
LATEST_VERSION=$(
    curl -s "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep -m1 '"tag_name":' \
    | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/'
)

if [ -z "${LATEST_VERSION}" ]; then
    echo "cannot detect latest difftastic version"
    exit 1
fi

echo "Latest version: ${LATEST_VERSION}"

URL="https://github.com/${REPO}/releases/download/${LATEST_VERSION}/${ASSET}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "Downloading ${URL}"
curl -fL -o "${TMP_DIR}/${ASSET}" "${URL}"

(cd "${TMP_DIR}" && ${UNPACK_COMMAND} "${ASSET}")

mkdir -p "${TARGET_DIR}"
mv "${TMP_DIR}/${EXECUTABLE_NAME}" "${TARGET_DIR}/${EXECUTABLE_NAME}"
chmod +x "${TARGET_DIR}/${EXECUTABLE_NAME}"

echo "difftastic ${LATEST_VERSION} installed to ${TARGET_DIR}/${EXECUTABLE_NAME}"
