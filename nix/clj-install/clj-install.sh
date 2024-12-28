#!/usr/bin/env sh
set -o errexit -o nounset

curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh

chmod +x linux-install.sh

TARGET="${DEVELOPMENT_BIN}/clojure"

./linux-install.sh  --prefix "${TARGET}" 

if [ -f "${HOME}/bin/clojure" ]; then
    rm "${HOME}/bin/clojure"
fi

ln -s "${TARGET}/bin" ~/bin/clojure

