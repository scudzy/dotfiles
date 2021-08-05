#!/usr/bin/env bash
#
# 7zz scripts
start="$(date +%s)"
### start of scripts
echo -n "Please enter a filename [specify fullpath]: "
read -r filename
target="$1"
datetime="$(date +"%d%m%Y-%H%M")"
file="$filename-$datetime.7z"
echo ""
echo -e "Zipping \e[0;31m$file\e[0m\n"
7zz a -t7z "$file" -m0=lzma2 -mmt=2 -mx=5 -p065195 -mhe=on -bt "$target" '-xr!.git' '-ax!*.7z'
7zz h -scrcsha256 "$file"
sha256sum "$file" > "$file.sha256"

[ $# -eq 0 ] && display_usage
while getopts ":hs:p:" arg; do
  case $arg in
    h | *) # Display help.
      display_usage
      exit 0
      ;;
  esac
done

display_usage () {
    echo ""
    echo -e "\t\e[1m7zip archive scripts v1.0 \e[0m\n"
    echo ""
    echo -e "\tUsage: 7zza.sh [Target folder] \n"
    echo -e "\t\e[1;33me.g: 7zza.sh $HOME/firefox \e[0m\n"
    echo ""
    echo -e "\tAuthor: scudzy@icloud.com \n"
    exit 0
}

# Execution time
end="$(date +%s)"
total="$(( end - start ))"
echo -e "Running in \033[1;32m""$total""\033[0m seconds"