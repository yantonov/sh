#!/bin/sh

# kill processes

if [ $# -eq 0 ]; then
    echo "usage $0 <string to grep>"
    exit 0
fi

ps -ef | grep $1 | grep -v 'grep' | awk '{print $2}' | xargs -n 1 kill -9
