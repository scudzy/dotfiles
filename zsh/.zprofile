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