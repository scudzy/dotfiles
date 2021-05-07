#!/usr/bin/env sh
#
# 7zz scripts
start="$(date +%s)"
printf "Please enter a filename [specify fullpath]: "
read -r filename
#nline=$filename
target="$1"
datetime="$(date +"%d%m%Y-%H%M")"
file="$filename-$datetime.7z"
printf "\n"
printf "Zipping \e[0;31m$file\e[0m"
7zz a -t7z "$file" -m0=lzma2 -mmt=2 -mx=5 -p065195 -mhe=on -bt "$target" '-xr!.git' '-ax!*.7z'
7zz h -scrcsha256 "$file"

# Execution time
end="$(date +%s)"
total="$(( end - start ))"
printf "Running in \033[1;32m""$total""\033[0m seconds\n"