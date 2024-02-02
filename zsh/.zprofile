# docker service
if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if service docker status 2>&1 | grep -q "is not running"; then
        wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
            --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi

# wslinterop
if [[ -v SSH_CLIENT ]]; then
	TMPFILE=$(mktemp)
	systemctl show-environment | awk '{print "export "$0}' >> $TMPFILE
	source $TMPFILE
	rm $TMPFILE
fi

# if [[ -f "${ZDOTDIR}/.zalias" ]]; then 
#     source "${ZDOTDIR}/.zalias"
#     printf "\nsourcing .zalias"
#     else
#     printf "\n404 - File not found\n" 
# fi

# if [[ -f "${ZDOTDIR}/xdg.zsh" ]]; then 
#     source "${ZDOTDIR}/xdg.zsh"
#     printf "\nsourcing xdg\n"
#     else
#     printf "404 - File not found\n"  
# fi

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip3
# pip zsh completion end

