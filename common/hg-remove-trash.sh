#!/bin/bash

# remove trash tracked files

# tracked files
# orig files
hg remove "glob:**.orig"
# rejected files
hg remove "glob:**.rej"

# untracked files
# orig files
hg purge "glob:**/*.orig" --all
# rej files
hg purge "glob:**/*.rej" --all