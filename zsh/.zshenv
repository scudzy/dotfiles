# ~/.zshenv should only be a one-liner that sources this file
# echo "source ~/.config/zsh/.zshenv" >| ~/.zshenv

export ZDOTDIR=~/dotfiles/zsh
export DOTFILES=~/dotfiles
# Set XDG dirs
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=~/.xdg

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=~/Users/Desktop
  export XDG_DOCUMENTS_DIR=~/Users/Documents
  export XDG_DOWNLOAD_DIR=~/Users/Downloads
  export XDG_MUSIC_DIR=~/Users/Music
  export XDG_PICTURES_DIR=~/Users/Pictures
  export XDG_VIDEOS_DIR=~/Users/Videos
fi

# Add all local binary paths to the system path.
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GOROOT="/usr/local/go"
export GOPATH="${HOME}/go"
export PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"
export PYTHONPATH="$PATH:/usr/bin/python3.8/"
export PASSWORD_STORE_ENABLE_EXTENSIONS='true'
export PASSWORD_STORE_EXTENSIONS_DIR='$HOME/.password-store/.extensions'
export RCLONE_PASSWORD_COMMAND="pass garbage/wsl2/rclone-deb10"

# If you come from bash you might have to change your $PATH.
export PATH=${HOME}/.local/bin:${HOME}/dotfiles/sh:${HOME}/.local/lib/python3.8/site-packages:/sbin:$PATH
