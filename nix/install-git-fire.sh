#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

git clone https://github.com/qw3rtman/git-fire.git
chmod +x git-fire/git-fire
