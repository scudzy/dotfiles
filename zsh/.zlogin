# Display bottle WARNING
#if [[ -v INSIDE_GENIE ]]; then
#    echo -e "\e[92m * Safely within bottle.\e[39m \e[0m"
#  else
#    echo -e "\e[97;101m * WARNING: Operating outside genie bottle. Systemd-dependent functions won't.\e[39m \e[0m"
#fi
#
[[ -z "$DISPLAY" && $XDG_VTNR -eq 1 ]] && exec startx
[[ -z "$DISPLAY" && $XDG_VTNR -eq 1 && -z "$SSH_CONNECTION" ]] && exec startx
