#ZSH_DISABLE_COMPFIX=true
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/scudzy/.oh-my-zsh"
export DOTFILES="/home/scudzy/dotfiles/"
export GOROOT="/usr/lib/go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
export PYTHONPATH="/usr/bin/python3.7/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# ZSH Autocomplete
#source ~/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
#ZSH_THEME_RANDOM_CANDIDATES=( "agnoster" "spaceship" )
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  github
  common-aliases
  nmap
  sudo
  colored-man-pages
  colorize
  pip
  python
  github
  tmux
  node
  nmap
  nvm
  command-not-found
  emoji
  ripgrep
  systemd
  zsh_reload
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-interactive-cd
  zsh-completions
  )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
fpath=(/usr/local/share/zsh/site-functions/_gh $fpath)

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR="vim"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom Aliases
alias speed="cmd /c speedtest"
alias pyupg="pip3 freeze --local |sed -rn 's/^([^=# \t\\][^ \t=]*)=.*/echo; echo Processing \1 ...; pip3 install -U \1/p' |sh"
alias c="calc"
alias suu="sudo apt update && sudo apt upgrade -y"
alias dfah="df -aH"
alias dush="du -sh"
alias pwsh="/c/Program\ Files/Powershell/7/pwsh.exe"
alias cmd="/c/windows/system32/cmd.exe"
alias powershell="/c/windows/system32/windowspowershell/v1.0/powershell.exe"
alias st3="/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"
alias path="echo $PATH"
alias rmgitd="find . -type d -name ".git" -exec rm -rf {} +"
alias wttr="curl -s 'wttr.in/Kuantan?0qTm'"
alias wttr4="curl -s 'wttr.in/Kuantan?format=4'"
alias choco="/c/ProgramData/chocolatey/bin/choco.exe"
alias fast="cmd /c fast -u"
alias csu="powershell choco upgrade all -y && powershell scoop update && powershell scoop status"
alias noxterm="nohup xfce4-terminal >/dev/null 2>&1 & sleep 3"
alias noff="nohup firefox >/dev/null 2>&1 & sleep 3"
alias tio-com3="tio --baudrate 9600 --databits 8 --flow none --stopbits 1 --parity none /dev/tty3"
alias tio-com4="tio --baudrate 9600 --databits 8 --flow none --stopbits 1 --parity none /dev/tty4"
alias tio-com6="tio --baudrate 9600 --databits 8 --flow none --stopbits 1 --parity none /dev/tty6"
alias pm2021="cd '/d/OneDrive/Documents/Business Doc/JPNM Pahang/PM 2021/PM2021/'"
alias cc="currency_converter $@"
alias rclGdrv="rclone --exclude ".git/" sync '/home/scudzy/dotfiles' 'Gdrive:/dotfiles' --transfers=8 --stats=1s --drive-chunk-size=128M --tpslimit=10 --tpslimit-burst=10 -u -P -v"
alias ll="colorls -oA --sd"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ipjson="curljson http://ip-api.com/json/ && curljson http://edns.ip-api.com/json/"
alias pyv="pyvoc -w $@"

# Launch neofetch on login
echo ""
if [ -f /usr/bin/neofetch ]; then neofetch; fi
echo ""
curl -s 'wttr.in/Kuantan, Malaysia?m0Fq&format=4'
genie -v -i

# Checking Interactive v.s. Non-Interactive
#[[ -o interactive ]] && echo "Interactive" || echo "Non-Interactive"
#
# Checking Login v.s. Non-Login
[[ -o login ]] && echo "Login" || echo "Non-Login"
echo ""

# PATH
# export PATH="${PATH}:/C/Users/scudz/AppData/Roaming/npm"
export PATH="${PATH}:/home/scudzy/.local/bin"
export PATH="${PATH}:/home/scudzy/dotfiles/sh"

# xterm modes
if [ "$TERM" != "xterm-256color" ]; then
      export TERM=xterm-256color
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

## Nicer shell experience
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD; # make ls more colorful as well
export HISTSIZE=32768; # Larger bash history (allow 32³ entries; default is 500)
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups; # Remove duplicates from history. I use `git status` a lot.
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"; # Make some commands not show up in history
export LANG="en_US.UTF-8"; # Language formatting is still important
export LC_ALL="en_US.UTF-8"; # byte-wise sorting and force language for those pesky apps
export MANPAGER="less -X"; # Less is more
export GPG_TTY=$(tty); # for gpg key management

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

# Set ls color
if ls --color -d . >/dev/null 2>&1; then  # GNU ls
  export COLUMNS  # Remember columns for subprocesses.
  eval "$(dircolors)"
  function ls {
    command ls -F -h --color=always -v --author --time-style=long-iso -C "$@" | less -R -X -F
  }
  alias ls='ls -F -h --color=always -v --author --time-style=long-iso'
#  alias ll='ls -alF'
  alias l='ls -l'
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--color=dark"

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

# fzf with man
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

# Functions
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper

## Powerline
GOPATH=$HOME/go
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
    }
    if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Limit number of lines and entries in the history. HISTFILESIZE controls the
# history file on disk and HISTSIZE controls lines stored in memory.
export HISTFILESIZE=50000
export HISTSIZE=50000

# Add a timestamp to each command.
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# Duplicate lines and lines starting with a space are not put into the history.
export HISTCONTROL=ignoreboth

# Improve output of less for binary files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load aliases if they exist.
#[ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases"
#[ -f "${HOME}/.aliases.local" ] && source "${HOME}/.aliases.local"

# Determine git branch.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set a non-distracting prompt.
PS1='\[[01;32m\]\u@\h\[[00m\]:\[[01;34m\]\w\[[00m\] \[[01;33m\]$(parse_git_branch)\[[00m\]\$ '

# If it's an xterm compatible terminal, set the title to user@host: dir.
case "${TERM}" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
    ;;
*)
    ;;
esac

# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then
    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"

    # Allows your gpg passphrase prompt to spawn (useful for signing commits).
    export GPG_TTY=$(tty)
fi

# WSL 1 specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    if [ "$(umask)" = "0000" ]; then
        umask 0022
    fi

    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY=:0
fi

# Auto Completion
autoload -U compinit
zstyle '.completion:*' menu select
zmodload zsh/complist
compinit -i
_comp_options+=(globdots)

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Options
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells

# Improve autocompletion style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# gh cli completion
gh completion -s zsh > /usr/local/share/zsh/site-functions/_gh

# Turn off power status when using spaceship prompt
#export SPACESHIP_BATTERY_SHOW=false

# Colorls tab completion
source $(dirname $(gem which colorls))/tab_complete.sh

# Windows Terminal Title
settitle () {
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      echo -ne '\033]0;'"$1"'\a'
}

# Vcxsvr
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

# XDG
export XDG_RUNTIME_DIR=//tmp/service-scudzy.aqX
export RUNLEVEL=3

GITSTATUS_LOG_LEVEL=DEBUG
