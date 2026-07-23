#!/bin/bash

# list of installed packages for debian based systems
dpkg --get-selections | grep -v deinstall
