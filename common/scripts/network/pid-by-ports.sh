#!/bin/sh

# list of listening ports

lsof -i -P | grep -i "listen"
