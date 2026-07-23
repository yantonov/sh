#!/usr/bin/env sh
set -o errexit -o nounset

# https://github.com/karol-broda/snitch
docker run -it --rm --net=host --pid=host --cap-add=SYS_PTRACE ghcr.io/karol-broda/snitch:latest-ubuntu
