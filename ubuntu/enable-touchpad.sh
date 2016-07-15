#!/bin/bash

TOUCHPAD_DEVICE_ID=$(`dirname $0`"/get-touchpad-id.sh")

ENABLE_SCRIPT=`dirname $0`"/enable-input-device.sh"
${ENABLE_SCRIPT} ${TOUCHPAD_DEVICE_ID} 1
