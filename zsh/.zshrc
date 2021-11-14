start="$(date +%s)"
#zmodload zsh/zprof
#zmodload -i zsh/complist
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export DOTFILES=~/dotfiles
export ZDOTDIR=~/dotfiles/zsh

# VCXSRV
WSL2IP=$(/sbin/ip route | awk '/default/ { print $3 }')
export PULSE_SERVER=tcp:"$WSL2IP"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL2IP:0.0
export NO_AT_BRIDGE=1

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

export EDITOR=vim
export VISUAL=vim

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# # # To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh/.p10k.zsh.
# [[ ! -f ~/dotfiles/zsh/.p10k.zsh ]] || source ~/dotfiles/zsh/.p10k.zsh

# powerline9k prompt
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

source $ZSH/oh-my-zsh.sh

# Default programs to run.
## Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
         tmux
         fzf
         sudo
         python
         git
         colored-man-pages
         command-not-found
         zsh-interactive-cd
         systemd
        )

# User configuration

# Startup
#if [ -f /usr/bin/neofetch ]; then neofetch; fi
#ssscurl -s 'wttr.in/Kuantan, Malaysia?m0Fq&format=4'

# Checking Interactive v.s. Non-Interactive
#[[ -o interactive ]] && echo "Interactive" || echo "Non-Interactive"

# Checking Login v.s. Non-Login
[[ -o login ]] && echo "Login" || echo "Non-Login"

# grc
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
for cmd in g++ gas head make ld ping6 tail traceroute6 $( ls /usr/share/grc/ ); do
    cmd="${cmd##*conf.}"
    type "${cmd}" >/dev/null 2>&1 && alias "${cmd}"="$( which grc ) --colour=auto ${cmd}"
done

# xterm modes
if [ "$TERM" != "xterm-256color" ]; then
      export TERM=xterm-256color
fi

# Uncomment the following line to automatically clear errors after showing
# them once. This not only clears the error for powerline-go, but also for
# everything else you run in that shell. Don't enable this if you're not
# sure this is what you want.

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)

# fzf customization
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

# Ripgrep
#export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
export RG_PREFIX="rg --column -n --no-heading --color=always -S --max-columns=150 "

# Color Ayu Mirage
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
    --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
    --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
    --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

# Determine git branch.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
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

# fzf forgit
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh

# powerline-status

# powerline-daemon -q
# source ~/.local/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh

/usr/bin/powerline-daemon -q
source /usr/share/powerline/bindings/zsh/powerline.zsh

# # ruby rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init - --no-rehash)"

# z.lua
#eval "$(lua ~/z.lua-1.8.12/z.lua --init zsh)"
eval "$(lua ~/dotfiles/z.lua/z.lua --init zsh enhanced once fzf)"

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}

# Windows Terminal
function settitle () {
  export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
  echo -ne '\033]0;'"$1"'\a'
}

# # Enable gpg-agent if it is not running
# GPG_AGENT_SOCKET="${HOME}/.gnupg/S.gpg-agent.ssh"
# if [ ! -S $GPG_AGENT_SOCKET ]; then
#     gpgconf --kill gpg-agent
#     gpg-agent --daemon --enable-ssh-support >/dev/null 2>&1
#     export GPG_TTY=$(tty)
# fi

# # Set SSH to use gpg-agent if it is configured to do so
# GNUPGCONFIG=${GNUPGHOME:-"${HOME}/.gnupg/gpg-agent.conf"}
# if grep -q enable-ssh-support "$GNUPGCONFIG"; then
#     unset SSH_AGENT_PID
#     export SSH_AUTH_SOCK=$GPG_AGENT_SOCKET
# fi

eval "$(oh-my-posh --init --shell zsh --config ~/dotfiles/.poshthemes/pure.omp.json)"

# the fuck alias
eval $(thefuck --alias)

### Path ref XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
### Path ref XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
### Path ref XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

### Load pz plugins
PZ_PLUGIN_HOME="${ZDOTDIR:-$HOME/dotfiles/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
source $PZ_PLUGIN_HOME/pz/pz.zsh

pz source mattmc3/zshrc.d

### Added by Zinit's installer
if [[ ! -f ${ZDOTDIR}/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZDOTDIR/.zinit" && command chmod g-rwX "$ZDOTDIR/.zinit"
    command git clone https://github.com/zdharma/zinit "$ZDOTDIR/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit load zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

## Zinit Setting plugins
# zinit snippet OMZP::git
# zinit snippet OMZP::tmux
# zinit snippet OMZP::fzf
# zinit snippet OMZP::sudo
# zinit snippet OMZP::colored-man-pages
# zinit snippet OMZP::command-not-found
# zinit snippet OMZP::python
# zinit snippet OMZP::systemd
# zinit snippet OMZP::zsh-interactive-cd

# # omz lib
# zinit snippet OMZL::git.zsh
# zinit snippet OMZL::functions.zsh
# zinit snippet OMZL::clipboard.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

# # Load powerlevel10k theme
# zinit ice depth"1" # git clone depth
# zinit light romkatv/powerlevel10k

# # prompt pure
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure
## End of Zinit's installer chunk

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fix wsl2 resolv.conf
echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8\n" | sudo tee /etc/resolv.conf > /dev/null

# # pure prompt
# autoload -Uz promptinit
# promptinit
# prompt pure
# optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10
# # change the path color
# zstyle :prompt:pure:path color blue
# # change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:*' color cyan
# # turn on git stash status
# zstyle :prompt:pure:git:stash show yes

# Git
autoload -Uz vcs_info
precmd_vcs_info() vcs_info
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

## Auto Completion -------------- SOURCE BEFORE THIS LINE

### zsh builtin AUTOLOAD
autoload -Uz compinit
compinit -i

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
zstyle ':xdg-basedirs:*' apps $XDG_APPS
# zsh-notify
zstyle ':notify:*' error-title "Command failed (in #{time_elapsed} seconds)"
zstyle ':notify:*' success-title "Command finished (in #{time_elapsed} seconds)"
zstyle ':notify:*' app-name sh
zstyle ':notify:*' error-log /dev/null

# load function folders ----------- NEVER DELETE BELOW RHIS LINE
fpath=( $ZDOTDIR/functions "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# Execution time
end="$(date +%s)"
total="$(( end - start ))"
printf "\e[0;97m 💠 Loading your blazing 🚀 fast ⚡ shell in\e[39m \e[1;92;5m$total\e[0m 🔥 \e[0;97mseconds 👻 \e[0m\n"

