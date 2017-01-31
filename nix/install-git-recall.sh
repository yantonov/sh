#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

git clone https://github.com/Fakerr/git-recall.git
chmod +x git-recall/git-recall
