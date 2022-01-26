# wslinterop
if [[ -v SSH_CLIENT ]]; then
	TMPFILE=$(mktemp)
	systemctl show-environment | awk '{print "export "$0}' >> $TMPFILE
	source $TMPFILE
	rm $TMPFILE
fi

# Are we in the bottle?
if [[ ! -v INSIDE_GENIE ]]; then
	read -p "yn? * Not inside the genie bottle; enter it? " yn
	echo

	if [[ $yn == "y" ]]; then
		echo "Starting genie:"
		exec /usr/bin/genie -s
	fi
fi

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
