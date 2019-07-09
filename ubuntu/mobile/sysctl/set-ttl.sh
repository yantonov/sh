#!/bin/bash

NEW_TTL_VALUE="$1"

if [ -z "${NEW_TTL_VALUE}" ]; then
    echo "Usage: ${SCRIPT} TTL_VALUE"
    exit -1
fi

echo "Current ttl value is equal to:"
sudo sysctl net.ipv4.ip_default_ttl="${NEW_TTL_VALUE}"
