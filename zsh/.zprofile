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

# browserpass gpg
if [ -z "$(pgrep gpg-agent)" ]; then
    gpgconf --launch gpg-agent
    # I use the above method because the following method
    # doesn't set GPG_AGENT_INFO or GPG_TTY and has a bug
    # setting SSH_AUTH_SOCK if you use socket redirection:
    #   eval $(gpg-agent --homedir $HOME/.gnupg --daemon)
fi
if [ -z "$(pgrep dirmngr)" ]; then
    dirmngr --homedir $HOME/.gnupg --daemon >/dev/null 2>&1
    # I use the above method to consistently set vars in .bashrc
    # rather than the following:
    #   eval $(dirmngr --homedir $HOME/.gnupg --daemon)
fi
