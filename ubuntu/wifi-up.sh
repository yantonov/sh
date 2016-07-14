#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: wifi-up.sh SID"
else
  nmcli c up id $1
fi
