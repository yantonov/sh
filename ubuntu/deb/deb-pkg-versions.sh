#!/bin/bash

# local and remote package versions

if [ $# -eq 0 ]
then
    SCRIPT_NAME=`basename $0`
    echo "Usage: $SCRIPT_NAME package_name"
else
    PACKAGE=$1
    apt-cache policy $PACKAGE
fi
