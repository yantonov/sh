#!/usr/bin/env bash
set -eu

PLATFORM="$(uname)"

case "${PLATFORM}" in
    Linux)
        FILENAME="delta-0.18.2-x86_64-unknown-linux-musl.tar.gz"
        URL="https://github.com/dandavison/delta/releases/download/0.18.2/${FILENAME}"
        UNPACK_COMMAND="tar xvfz"
        ;;
    Darwin)
        echo "not supported"
        exit 1
        ;;
    MINGW*)
        FILENAME="delta-0.18.2-x86_64-pc-windows-msvc.zip"
        URL="https://github.com/dandavison/delta/releases/download/0.18.2/${FILENAME}"
        UNPACK_COMMAND="unzip -d ."        
        ;;
    *)
        echo "cant detect os automatically"      
        exit 1
        ;;
esac

cd "${HOME}/bin"
curl -L $URL -o $FILENAME
"${UNPACK_COMMAND} $FILENAME"
rm "${FILENAME}"

echo "ok"
