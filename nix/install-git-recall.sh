#!/bin/sh

if [ -z "$GIT_REPOS" ]; then
    echo "GIT_REPOS env var is undefined"
    exit 1
fi

cd "${GIT_REPOS}"

APP_NAME="git-recall"

if [ -d "${APP_NAME}" ]; then
    echo "${APP_NAME} is already exist"
    exit 1
fi

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

git clone https://github.com/Fakerr/git-recall.git
chmod +x git-recall/git-recall

mkdir -p "${HOME}/bin"
cd "${HOME}/bin"
ln -s "${GIT_REPOS}/${APP_NAME}" ${APP_NAME}

