# ${HOME}/.zshenv should only be a one-liner that sources this file
# echo "source ${HOME}/.config/zsh/.zshenv" >| ${HOME}/.zshenv

export ZDOTDIR="${HOME}/.dotfiles/zsh"
export DOTFILES="${HOME}/.dotfiles"
# Set XDG dirs
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="${HOME}/.xdg"
export XDG_DATA_DIRS="${HOME}/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/share/gnome:/usr/local/share/:/usr/share/"

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR="${HOME}/Users/Desktop"
  export XDG_DOCUMENTS_DIR="${HOME}/Users/Documents"
  export XDG_DOWNLOAD_DIR="${HOME}/Users/Downloads"
  export XDG_MUSIC_DIR="${HOME}/Users/Music"
  export XDG_PICTURES_DIR="${HOME}/Users/Pictures"
  export XDG_VIDEOS_DIR="${HOME}/Users/Videos"
fi

# Add all local binary paths to the system path.
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GOROOT="/usr/local/go1.17.4/"
export GOPATH="${HOME}/go"
export PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"
export PYTHONPATH="${HOME}/.local/lib/python3.8/site-packages"
export PASSWORD_STORE_DIR="${HOME}/.password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
export PASSWORD_STORE_EXTENSIONS_DIR="${HOME}/.password-store/.extensions"
export PASSWORD_STORE_GENERATED_LENGTH="20"
export RCLONE_PASSWORD_COMMAND="pass garbage/wsl2/rclone-deb10"
export COWPATH="/usr/share/cowsay/cows/"
# If you come from bash you might have to change your $PATH.
export PATH="${HOME}/.local/bin:${HOME}/.dotfiles/sh:/c/Windows/System32/:$PATH"
#export PATH="${HOME}/.local/bin:${HOME}/dotfiles/sh:${HOME}/.local/lib/python3.9/site-packages:/c/Windows/System32/:$PATH"
