#!/bin/bash

if [ $# -ne 2 ]; then    
    echo "Usage:" `dirname $0` "deviceId enable"
    echo "\t where deviceId - identifier of device (use xinput list to get it)"
    echo "\t enable - 0 or 1"
else
    DEVICE_ID=${1}

    ENABLE=${2}

    xinput set-prop ${DEVICE_ID} "Device Enabled" ${ENABLE}
fi
