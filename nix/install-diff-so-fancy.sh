#!/bin/sh

if [ -z "$GIT_REPOS" ]; then
    echo "GIT_REPOS env var is undefined"
    exit 1
fi

cd "${GIT_REPOS}"

APP_NAME="diff-so-fancy"

if [ -d "${APP_NAME}" ]; then
    echo "${APP_NAME} is already exist"
    exit 1
fi

git clone https://github.com/so-fancy/diff-so-fancy.git "${APP_NAME}"
chmod +x ${APP_NAME}/*.sh

mkdir -p "${HOME}/bin"
cd "${HOME}/bin"
ln -s "${GIT_REPOS}/${APP_NAME}" ${APP_NAME}
