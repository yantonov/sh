#!/bin/sh
set -eu

REPO="ynqa/jnv"
BIN_NAME="jnv"
INSTALL_DIR="${JNV_INSTALL_DIR:-$HOME/.local/bin}"

log() {
    printf '[jnv] %s\n' "$*"
}

die() {
    printf '[error] %s\n' "$*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_command() {
    command_exists "$1" || die "Required command not found: $1"
}

require_command curl
require_command tar

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        case "$ARCH" in
            arm64|aarch64)
                TARGET="aarch64-apple-darwin"
                ;;
            x86_64|amd64)
                TARGET="x86_64-apple-darwin"
                ;;
            *)
                die "Unsupported macOS architecture: $ARCH"
                ;;
        esac
        ;;

    Linux)
        case "$ARCH" in
            arm64|aarch64)
                TARGET="aarch64-unknown-linux-gnu"
                ;;
            x86_64|amd64)
                TARGET="x86_64-unknown-linux-gnu"
                ;;
            armv7l|armv7)
                TARGET="armv7-unknown-linux-gnueabihf"
                ;;
            *)
                die "Unsupported Linux architecture: $ARCH"
                ;;
        esac
        ;;

    *)
        die "Unsupported operating system: $OS"
        ;;
esac

ASSET="jnv-${TARGET}.tar.xz"
URL="https://github.com/${REPO}/releases/latest/download/${ASSET}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT INT TERM

ARCHIVE="${TMP_DIR}/${ASSET}"

log "Platform: ${OS}/${ARCH}"
log "Target: ${TARGET}"
log "Downloading latest jnv..."

curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --proto '=https' \
    --tlsv1.2 \
    "$URL" \
    --output "$ARCHIVE"

log "Extracting..."

tar -xJf "$ARCHIVE" -C "$TMP_DIR"

BINARY="$(find "$TMP_DIR" -type f -name "$BIN_NAME" -perm -u+x -print -quit)"

if [ -z "$BINARY" ]; then
    die "jnv binary was not found in the downloaded archive"
fi

mkdir -p "$INSTALL_DIR"

cp "$BINARY" "${INSTALL_DIR}/${BIN_NAME}"
chmod 755 "${INSTALL_DIR}/${BIN_NAME}"

log "Installed jnv to ${INSTALL_DIR}/${BIN_NAME}"

if "${INSTALL_DIR}/${BIN_NAME}" --version >/dev/null 2>&1; then
    "${INSTALL_DIR}/${BIN_NAME}" --version
fi

case ":${PATH}:" in
    *:"${INSTALL_DIR}":*)
        ;;
    *)
        log "Add ${INSTALL_DIR} to your PATH:"
        printf '  export PATH="%s:$PATH"\n' "$INSTALL_DIR"
        ;;
esac

