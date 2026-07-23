#!/bin/bash

# check version of package before you install it

if [ $# -eq 0 ]
then
    SCRIPT_NAME=`basename $0`
    echo "Usage: $SCRIPT_NAME package_name"
else
    PACKAGE=$1
    apt-get -s install $PACKAGE
fi
