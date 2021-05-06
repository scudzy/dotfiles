#!/usr/bin/env bash
#
# tar scripts

echo -n "Please enter a filename: "
read filename
nlines=$filename

datetime=$(date +"%d%m%Y-%H%M")
file=$filename-$datetime.tar.gz

# Run the scripts
echo "Zipping $1"
tar --exclude='.git' --exclude='*.gz' --exclude='*.7z' -czvf $file $1
