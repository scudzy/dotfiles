# ~/.zshenv should only be a one-liner that sources this file
# echo "source ~/.config/zsh/.zshenv" >| ~/.zshenv

export ZDOTDIR=~/dotfiles/.zsh

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

[[ -d ~/dotfiles ]] && export DOTFILES=~/dotfiles
