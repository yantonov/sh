#!/usr/bin/env bash
set -eu

PLATFORM="$(uname)"

case "${PLATFORM}" in
    Linux)
        OS="linux"
        FILENAME="delta-0.18.2-x86_64-unknown-linux-musl.tar.gz"
        URL="https://github.com/dandavison/delta/releases/download/0.18.2/${FILENAME}"               
        ;;
    Darwin)
        OS="darwin"
        echo "not supported"
        exit 1
        ;;
    *)
        echo "cant detect os automatically"      
        exit 1
        ;;
esac

cd "${HOME}/bin"
curl -L $URL -o $FILENAME
tar xvfz $FILENAME
rm $FILENAME

echo "ok"
