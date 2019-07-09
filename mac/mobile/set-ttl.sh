#!/bin/bash

SCRIPT="$(basename "$0")"

NEW_TTL_VALUE="$1"

if [ -z "${NEW_TTL_VALUE}" ]; then
    echo "Usage: ${SCRIPT} TTL_VALUE"
    exit 1
fi

echo "Current TTL value is equal to:"
sudo sysctl net.inet.ip.ttl=${NEW_TTL_VALUE}
