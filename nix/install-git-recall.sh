#!/bin/sh

if [ -z "$HOME_BIN" ]; then
    echo "HOME_BIN env var is undefined"
    exit 1
fi

cd "${HOME_BIN}"

APP_NAME="git-recall"

if [ -d "${APP_NAME}" ]; then
    echo "${APP_NAME} is already exist"
    exit 1
fi

git clone https://github.com/Fakerr/git-recall.git  "${APP_NAME}"
chmod +x ${APP_NAME}/git*
