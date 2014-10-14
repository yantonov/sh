#!/bin/bash

idIsEqualTo=`xinput list | grep -Po ".*TouchPad.*\s+id=(\d+)" | grep -Po "id=(\d+)"`
echo ${idIsEqualTo:3}
