#!/bin/bash

# situation: hg verify informed about errors
# but it was possible to pull any selected branch
# this tiny snippet was helpful to preserve all latest changes

branches=`hg branches | cut -d \  -f 1 | xargs echo `

for br in $branches
do
    echo "hg pull -b $br"
done
