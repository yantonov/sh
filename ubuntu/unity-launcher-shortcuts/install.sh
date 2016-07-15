#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

TARGET_DIR="$HOME/.local/share/applications"
mkdir -p $TARGET_DIR

files=`find templates -type f -name "*.desktop"`

escaped_home_dir=`echo $HOME | sed -- "s/\//\\\\\\\\\//g"`

for f in $files
do
    echo "---"
    filename_to_patch=`basename $f`
    echo "process file: " $filename_to_patch
    echo "begin patch username"
    new_desktop_file_content=`cat $f | sed -- "s/\\$HOME/$escaped_home_dir/g"`
    echo "end patch username"
    echo "generate target file:" $TARGET_DIR/$filename_to_patch
    echo "$new_desktop_file_content" > $TARGET_DIR/$filename_to_patch
done
echo "---"
echo "ok"
# find . -type f -name "*.desktop" -exec cat {} | sed "s/<username>/$USERNAME/g" +

