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

## Nicer shell experience
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD; # make ls more colorful as well
export HISTSIZE=100000; # Larger bash history (allow 32³ entries; default is 500)
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups; # Remove duplicates from history. I use `git status` a lot.
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"; # Make some commands not show up in history
export HISTTIMEFORMAT='%F-%T ';
export SAVEHIST=$HISTSIZE;
export HISTFILE=$HOME/.zsh_history;
export LANG="en_US.UTF-8"; # Language formatting is still important
export LC_ALL="en_US.UTF-8"; # byte-wise sorting and force language for those pesky apps

# set options for less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
# or the short version
export LESS='-F -i -J -M -R -W -x4 -X -z-4'

# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

# Color Gruvbox Dark
export FZF_DEFAULT_OPTS='
    --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
    --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

# Color Ayu Mirage
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
    --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
    --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
    --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'

# VCXSRV
WSL2IP=$(/sbin/ip route | awk '/default/ { print $3 }')
export PULSE_SERVER=tcp:"$WSL2IP"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL2IP:0.0
export NO_AT_BRIDGE=1
