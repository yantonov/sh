#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: wifi-up.sh SID"
    exit 1
else
    if [ "$1" == "--down" ]; then
        if [ -z "$2" ]; then
            echo "Usage: wifi-up.sh --down SID"
            exit 1
        else
            SID="$2"
            COMMAND="down"
        fi
    else
        SID="$1"
        COMMAND="up"
    fi
fi

nmcli c "${COMMAND}" id "${SID}"
