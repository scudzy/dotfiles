# ${HOME}/.zshenv should only be a one-liner that sources this file
# echo "source ${HOME}/.config/zsh/.zshenv" >| ${HOME}/.zshenv

export ZDOTDIR="${HOME}/.dotfiles/zsh"
export DOTFILES="${HOME}/.dotfiles"

# Set XDG dirs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_RUNTIME_DIR="${HOME}/.local/service-scudzy.aqX}"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/usr/share/gnome"
# export XDG_DATA_DIRS="${HOME}/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/share/gnome:/usr/local/share/:/usr/share/"
# export RUNLEVEL=3

export ICEAUTHORITY="$XDG_RUNTIME_DIR/ICEauthority"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export SCREENDIR="$XDG_RUNTIME_DIR/screen"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR/tmux"

if [[ "$OSTYPE" == linux-gnu ]]; then
  export XDG_DESKTOP_DIR="${HOME}/Users/Desktop"
  export XDG_DOCUMENTS_DIR="${HOME}/Users/Documents"
  export XDG_DOWNLOAD_DIR="${HOME}/Users/Downloads"
  export XDG_MUSIC_DIR="${HOME}/Users/Music"
  export XDG_PICTURES_DIR="${HOME}/Users/Pictures"
  export XDG_VIDEOS_DIR="${HOME}/Users/Videos"
fi

# bat
export PAGER='less'
export BAT_PAGER='less -R -F -+X --mouse'

export BAT_CONFIG_PATH='/home/scudzy/.config/bat/config'
export BAT_CONFIG_DIR='/home/scudzy/.config/bat'
export BAT_THEME='OneHalfDark'

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPATH="/usr/share/man:${HOME}/.local/share/zinit/polaris/man:${HOME}/.local/share/zinit/plugins/tj---git-extras/man"

### golang
export GOROOT="/usr/local/go/bin/"
export GOPATH="${HOME}/go"

### python
# export PYTHONHOME="/usr/lib/python3.11"
export PYTHONPATH="${HOME}/.local/lib/python3.11/site-packages"
export PYTHONSTARTUP="$DOTFILES/.pythonrc"

### pass
export PASSWORD_STORE_DIR="${HOME}/.password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
export PASSWORD_STORE_EXTENSIONS_DIR="${HOME}/.password-store/.extensions"
export PASSWORD_STORE_GENERATED_LENGTH="20"
# export PASSWORD_STORE_TOMB="/usr/bin/tomb"
# export PASSWORD_STORE_TOMB_FILE="${HOME}/.password.tomb"
# export PASSWORD_STORE_TOMB_KEY="${HOME}/.password.key.tomb"
# export PASSWORD_STORE_TOMB_SIZE=10

### rclone
export RCLONE_PASSWORD_COMMAND="pass scudzyDB/garbage/wsl2/rclone-deb12"

### cowsay
export COWPATH="/usr/share/cowsay/cows/"

# If you come from bash you might have to change your $PATH.
export PATH="${HOME}/.local/bin:${HOME}/.dotfiles/sh:/c/Windows/System32:/usr/local/go/bin:/var/lib/gems/3.1.0/:${HOME}/.local/share/npm/bin/:$PATH"

# wsl2 display
export WSL2IP="$(ip addr show eth0 | grep inet | awk '{print $2; exit;}' | sed 's/\(.*\).\{3\}$/\1/' )"
export DISPLAY=:0
export LIBGL_ALWAYS_INDIRECT=1
export NO_AT_BRIDGE=1

# x11
export XDG_CURRENT_DESKTOP="XFCE"

# thefuck
export THEFUCK_RULES='sudo:no_command'
export THEFUCK_EXCLUDE_RULES='git_pull:git_push'
export THEFUCK_REQUIRE_CONFIRMATION='true'
export THEFUCK_WAIT_COMMAND=10
export THEFUCK_NO_COLORS='false'
export THEFUCK_PRIORITY='no_command=9999:apt_get=100'
export THEFUCK_HISTORY_LIMIT='2000'
export THEFUCK_NUM_CLOSE_MATCHES='5'

### hisory bash or zsh
# export HISTFILE="$XDG_STATE_HOME"/bash/history
export HISTFILE="$XDG_STATE_HOME"/zsh/.zsh_history
export HISTSIZE=100000; # Larger bash history (allow 32³ entries; default is 500)
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups; # Remove duplicates from history. I use `git status` a lot.
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"; # Make some commands not show up in history
export HISTTIMEFORMAT='%F-%T ';
export SAVEHIST=$HISTSIZE;

### language
export LANG="en_US.UTF-8"; # Language formatting is still important
export LC_ALL="en_US.UTF-8"; # byte-wise sorting and force language for those pesky apps

# set options for less
export LESS="--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4"
# or the short version
export LESS="-F -i -J -M -R -W -x4 -X -z-4"

# Default apps
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="wslview"

# Ripgrep
export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
export RIPGREP_CONFIG_PATH="${DOTFILES}/.ripgreprc"
#export RG_PREFIX="rg --column -n --no-heading --color=always -S --max-columns=150 "

### Powerline-status
export POWERLINE_LOCATION="${HOME}/.local/pipx/venx/powerline-status/lib/python3.11/site-packages/powerline"
export POWERLINE_CONFIG_COMMAND="${HOME}/.local/bin/powerline-config"
export POWERLINE_ZSH_CONTINUATION="1"
export POWERLINE_ZSH_SELECT="1"

### p10k & Gitstatus
export POWERLEVEL9K_DISABLE_GITSTATUS="true"
export GITSTATUS_DAEMON="/home/scudzy/.local/share/zinit/plugins/romkatv---powerlevel10k/gitstatus/usrbin/gitstatusd"
export GITSTATUS_LOG_LEVEL=DEBUG
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export POWERLEVEL9K_VCS_MAX_INDEX_SIZE=10000000
typeset -g P10K_INSTANT_PROMPT=quiet

### deduplicated
typeset -U path cdpath fpath manpath

### tmux
export ZSH_TMUX_CONFIG="${HOME}/.config/tmux/tmux.conf"

### local library paths
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"
export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig"
export LDFLAGS="-L/usr/lib"
export CPPFLAGS="-I/usr/include"
export RUBYLIB="/usr/lib/x86_64-linux-gnu/ruby/vendor_ruby/"

### starship
export STARSHIP_CONFIG=~/home/scudzy/.config/starship.toml

### GWSL
export QT_SCALE_FACTOR=2

export fdatetime="$(date +%d%m%Y-%H%M)"

export NVM_DIR="/home/scudzy/.nvm"

export EZA_CONFIG_DIR="${XDG_CONFIG_HOME}/eza"

