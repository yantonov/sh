#!/usr/bin/env sh

# list broken symlinks for the current directory

find . -maxdepth 1 -type l ! -exec test -e {} \; -print
