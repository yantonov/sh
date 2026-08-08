#!/usr/bin/env sh
set -o errexit -o nounset

curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh

chmod +x linux-install.sh

TARGET="${DEVELOPMENT_BIN}/clojure"

./linux-install.sh  --prefix "${TARGET}" 

LOCAL_BIN_DIR="${LOCAL_BIN:-${HOME}/.local/bin}"

if [ -f "${LOCAL_BIN_DIR}/clojure" ]; then
    rm "${LOCAL_BIN_DIR}/clojure"
fi

ln -s "${TARGET}/bin" "${LOCAL_BIN_DIR}/clojure"

