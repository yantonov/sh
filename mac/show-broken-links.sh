#!/usr/bin/env sh

# list broken symlinks for the current directory

find -L . -type l -ls

