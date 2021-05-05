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

# Add all local binary paths to the system path.
export DOTFILES=~/dotfiles
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GOROOT="/usr/local/go"
export GOPATH="${HOME}/go"
export PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"
export PYTHONPATH="$PATH:/usr/bin/python3.8/"
export PASSWORD_STORE_ENABLE_EXTENSIONS='true'
export PASSWORD_STORE_EXTENSIONS_DIR='$HOME/.password-store/.extensions'
export RCLONE_PASSWORD_COMMAND="pass garbage/wsl2/rclone-deb10"
# Default programs to run.
export EDITOR="vim"
export SHELL_SESSIONS_DISABLE=1
# If you come from bash you might have to change your $PATH.
export PATH=${HOME}/.local/bin:${HOME}/dotfiles/sh:${HOME}/.local/lib/python3.8/site-packages:$PATH
