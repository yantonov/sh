#!/usr/bin/env sh
set -o errexit -o nounset

cd "$(dirname "$0")"

TARGET="${HOME}/Development/git/cli"
mkdir -p "${TARGET}"
cd "${TARGET}"

REPO_URL="git@github.com:yantonov/dot.git"
git clone "${REPO_URL}"
