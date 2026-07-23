#!/bin/bash

# list of listening ports

lsof -i -P | grep -i "listen"
