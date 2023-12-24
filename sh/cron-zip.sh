#!/bin/bash

# Define the source folder
source_folder="$HOME/.dotfiles"

# Define the destination folder
destination_folder="/d/Dropbox/Zip/wsl2/backup/"

# Define the filename format with the current date and time
filename="dotfiles-$(date '+%d%m%Y-%H%M').tar.xz"

# Create the tarball and compress with xz
tar --exclude='.git' --exclude='.cache' -cvf - ~/.dotfiles | xz -9zev >$filename
# md5sum $filename
md5_hash=$(md5sum "$filename" | awk '{print $1}')

echo "Backup completed: dotfiles_$filename.tar.xz"
echo "MD5 hash of $filename: $md5_hash"

mv -v $filename $destination_folder
