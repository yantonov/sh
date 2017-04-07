#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

git clone https://github.com/so-fancy/diff-so-fancy.git
chmod +x diff-so-fancy/*.sh
