#!/usr/bin/env bash
#
# 7zz foobar scripts

echo -n "Please enter a filename: "
read filename
nlines=$filename

datetime=$(date +"%d%m%Y-%H%M")
file=$filename-$datetime.7z

# Run the scripts
echo "Zipping $1"
7zz a -t7z -m0=lzma2 -mmt=2 -mx=9 -mfb=273 -md=96m -p065195 -mhe=on -ms=512m -bt $file $1
