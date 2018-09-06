#!/bin/sh

# grep process list by name and return list of process identifiers

if [ $# -eq 0 ]; then
    echo "usage $0 <string to grep>"
    exit 0
fi

ps -ef | grep $1 | grep -v 'grep' | awk '{print $2, $8, $9}'
