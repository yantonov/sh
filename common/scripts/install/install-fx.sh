#!/bin/sh

set -eu

REPO="antonmedv/fx"
VERSION="${1:-latest}"
INSTALL_DIR="${FX_INSTALL_DIR:-$HOME/.local/bin}"
BIN_NAME="fx"

log() {
    printf '[fx] %s\n' "$*"
}

die() {
    printf '[error] %s\n' "$*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

command_exists curl || die "Required command not found: curl"

if [ "$#" -gt 1 ]; then
    die "Usage: $0 [version]"
fi

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        case "$ARCH" in
            x86_64|amd64)
                ASSET="fx_darwin_amd64"
                ;;
            arm64|aarch64)
                ASSET="fx_darwin_arm64"
                ;;
            *)
                die "Unsupported macOS architecture: $ARCH"
                ;;
        esac
        ;;

    Linux)
        case "$ARCH" in
            x86_64|amd64)
                ASSET="fx_linux_amd64"
                ;;
            arm64|aarch64)
                ASSET="fx_linux_arm64"
                ;;
            *)
                die "Unsupported Linux architecture: $ARCH"
                ;;
        esac
        ;;

    MINGW*|MSYS*|CYGWIN*|Windows_NT)
        BIN_NAME="fx.exe"

        case "$ARCH" in
            x86_64|amd64)
                ASSET="fx_windows_amd64.exe"
                ;;
            arm64|aarch64)
                ASSET="fx_windows_arm64.exe"
                ;;
            *)
                die "Unsupported Windows architecture: $ARCH"
                ;;
        esac
        ;;

    *)
        die "Unsupported operating system: $OS"
        ;;
esac

if [ "$VERSION" = "latest" ]; then
    URL="https://github.com/${REPO}/releases/latest/download/${ASSET}"
else
    # Accept both "39.2.0" and "v39.2.0".
    case "$VERSION" in
        v*)
            TAG="$VERSION"
            ;;
        *)
            TAG="v$VERSION"
            ;;
    esac

    URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET}"
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT INT TERM

TMP_BIN="${TMP_DIR}/${BIN_NAME}"

log "Platform: ${OS}/${ARCH}"

if [ "$VERSION" = "latest" ]; then
    log "Installing latest version"
else
    log "Installing fx ${VERSION}"
fi

log "Downloading ${ASSET}..."

curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --proto '=https' \
    --tlsv1.2 \
    "$URL" \
    --output "$TMP_BIN"

[ -s "$TMP_BIN" ] || die "Downloaded file is empty"

mkdir -p "$INSTALL_DIR"

chmod 755 "$TMP_BIN"
mv "$TMP_BIN" "${INSTALL_DIR}/${BIN_NAME}"

log "Installed fx to ${INSTALL_DIR}/${BIN_NAME}"

if command_exists "${INSTALL_DIR}/${BIN_NAME}"; then
    "${INSTALL_DIR}/${BIN_NAME}" --version || true
fi

case ":${PATH}:" in
    *:"${INSTALL_DIR}":*)
        ;;
    *)
        log "Add ${INSTALL_DIR} to your PATH:"
        printf 'export PATH="%s:$PATH"\n' "$INSTALL_DIR"
        ;;
esac
