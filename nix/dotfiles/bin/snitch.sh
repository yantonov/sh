#!/usr/bin/env sh
set -o errexit -o nounset

docker run -it --rm --net=host --pid=host --cap-add=SYS_PTRACE ghcr.io/karol-broda/snitch:latest-ubuntu
