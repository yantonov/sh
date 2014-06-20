#!/bin/bash

TOUCHPAD_DEVICE_ID=13
# to get id run in terminal:
# xinput list

ENABLE_SCRIPT=`dirname $0`"/enable-input-device.sh"
${ENABLE_SCRIPT} ${TOUCHPAD_DEVICE_ID} 1
