#!/bin/sh
set -eu

# Upstream publishes bare binaries (no archive), but stopped attaching them
# after v1.0.0 -- v1.3.0+ ship source only, so /releases/latest/download/...
# is currently a 404 for every platform.
#
# The prebuilt binary is still tried first, and building from source with the
# Go toolchain is the fallback. If upstream ever attaches binaries to a new
# release, the fast path starts working again with no change here.

REPO="antonmedv/countdown"
MODULE="github.com/antonmedv/countdown"
VERSION="${COUNTDOWN_VERSION:-latest}"
BIN_NAME="countdown"
INSTALL_DIR="${COUNTDOWN_INSTALL_DIR:-$HOME/.local/bin}"

log() {
    printf '[countdown] %s\n' "$*"
}

die() {
    printf '[error] %s\n' "$*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

command_exists curl || die "Required command not found: curl"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        case "$ARCH" in
            x86_64|amd64)
                ASSET="countdown_darwin_amd64"
                ;;
            arm64|aarch64)
                # No darwin_arm64 build was ever published; the amd64 one
                # runs under Rosetta 2 on Apple Silicon.
                ASSET="countdown_darwin_amd64"
                ;;
            i386|i686)
                ASSET="countdown_darwin_386"
                ;;
            *)
                die "Unsupported macOS architecture: $ARCH"
                ;;
        esac
        ;;

    Linux)
        case "$ARCH" in
            x86_64|amd64)
                ASSET="countdown_linux_amd64"
                ;;
            arm64|aarch64)
                # No linux_arm64 build was ever published; the 32-bit arm one
                # only runs where 32-bit userspace support is installed.
                ASSET="countdown_linux_arm"
                ;;
            armv6l|armv7l|arm)
                ASSET="countdown_linux_arm"
                ;;
            i386|i686)
                ASSET="countdown_linux_386"
                ;;
            *)
                die "Unsupported Linux architecture: $ARCH"
                ;;
        esac
        ;;

    MINGW*|MSYS*|CYGWIN*|Windows_NT)
        BIN_NAME="countdown.exe"
        case "$ARCH" in
            x86_64|amd64)
                ASSET="countdown_windows_amd64.exe"
                ;;
            arm64|aarch64)
                # No windows_arm64 build was ever published; amd64 runs
                # emulated.
                ASSET="countdown_windows_amd64.exe"
                ;;
            i386|i686)
                ASSET="countdown_windows_386.exe"
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
    URL="https://github.com/${REPO}/releases/download/${VERSION}/${ASSET}"
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT INT TERM

log "Platform: ${OS}/${ARCH}"

install_binary() {
    log "Looking for a prebuilt binary: ${URL}"

    # --fail makes curl exit non-zero on 404, which is the signal to fall
    # back to a source build.
    if ! curl \
        --fail \
        --silent \
        --show-error \
        --location \
        --proto '=https' \
        --tlsv1.2 \
        "$URL" \
        --output "${TMP_DIR}/${BIN_NAME}" \
        2>/dev/null
    then
        log "No prebuilt binary published for ${VERSION}"
        return 1
    fi

    [ -s "${TMP_DIR}/${BIN_NAME}" ] || return 1

    mkdir -p "$INSTALL_DIR"
    cp "${TMP_DIR}/${BIN_NAME}" "${INSTALL_DIR}/${BIN_NAME}"
    chmod 755 "${INSTALL_DIR}/${BIN_NAME}"

    log "Installed prebuilt countdown to ${INSTALL_DIR}/${BIN_NAME}"
}

install_from_source() {
    command_exists go \
        || die "No prebuilt binary available and Go is not installed (see install-go.sh)"

    mkdir -p "$INSTALL_DIR"

    # go.exe does not understand MSYS paths like /c/Users/...
    GOBIN_DIR="$INSTALL_DIR"
    if command_exists cygpath; then
        GOBIN_DIR="$(cygpath -w "$INSTALL_DIR")"
    fi

    log "Building from source with $(go version)"
    log "Building ${MODULE}@${VERSION}..."

    GOBIN="$GOBIN_DIR" go install "${MODULE}@${VERSION}"

    [ -f "${INSTALL_DIR}/${BIN_NAME}" ] \
        || die "${BIN_NAME} was not produced in ${INSTALL_DIR}"

    chmod 755 "${INSTALL_DIR}/${BIN_NAME}"

    log "Installed source-built countdown to ${INSTALL_DIR}/${BIN_NAME}"
}

if [ "${COUNTDOWN_FROM_SOURCE:-0}" = "1" ]; then
    log "COUNTDOWN_FROM_SOURCE=1, skipping the prebuilt binary"
    install_from_source
elif ! install_binary; then
    install_from_source
fi

case ":${PATH}:" in
    *:"${INSTALL_DIR}":*)
        ;;
    *)
        log "Add ${INSTALL_DIR} to your PATH:"
        printf '  export PATH="%s:$PATH"\n' "$INSTALL_DIR"
        ;;
esac
