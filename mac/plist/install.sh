#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)

cp $SCRIPT_DIR/*.plist ~/Library/LaunchAgents/
