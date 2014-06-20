#!/bin/bash

TOUCHPAD_DEVICE_ID=13
# to get id run in terminal:
# xinput list

xinput set-prop ${TOUCHPAD_DEVICE_ID} "Device Enabled" f
