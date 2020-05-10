#!/bin/sh

if [ -z "$HOME_BIN" ]; then
    echo "HOME_BIN env var is undefined"
    exit 1
fi

cd "${HOME_BIN}"

APP_NAME="diff-so-fancy"

if [ -d "${APP_NAME}" ]; then
    echo "${APP_NAME} is already exist"
    exit 1
fi

git clone https://github.com/so-fancy/diff-so-fancy.git "${APP_NAME}"
chmod +x ${APP_NAME}/*.sh
