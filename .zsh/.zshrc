start=$(date +%s%N)
zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export DOTFILES=~/dotfiles

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel10k/powerlevel10k"
#eval "$(oh-my-posh --init --shell zsh --config ~/.poshthemes/hotstick.minimal.omp.json)"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   git
#   github
#   common-aliases
#   nmap
#   sudo
#   colored-man-pages
#   fzf
#   pip
#   python
#   github
#   tmux
#   nvm
#   command-not-found
#   ripgrep
#   systemd
#   zsh_reload
#   zsh-interactive-cd
#   fast-syntax-highlighting
#   zsh-xdg-basedirs
#   )

source $ZSH/oh-my-zsh.sh

# User configuration

# plugin variables
XDG_APPS=(
  gnupg
  pass
  less
  tmux
  wget
)

# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# Startup
#if [ -f /usr/bin/neofetch ]; then neofetch; fi
#ssscurl -s 'wttr.in/Kuantan, Malaysia?m0Fq&format=4'

# fzf forgit
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh

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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# powerline-status
#~/.local/bin/powerline-daemon -q
#source ~/.local/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

# Determine git branch.
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# ruby rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

# Powerline
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# z.lua
#eval "$(lua ~/z.lua-1.8.12/z.lua --init zsh)"
eval "$(lua ~/z.lua/z.lua --init zsh enhanced once fzf)"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ ! -f ~/.p10k.zsh ] || source ~/.p10k.zsh

# Enable gpg-agent if it is not running
GPG_AGENT_SOCKET="${XDG_DATA_HOME}/gnupg/S.gpg-agent.ssh"
if [ ! -S $GPG_AGENT_SOCKET ]; then
    gpgconf --kill gpg-agent
    gpg-agent --daemon --enable-ssh-support >/dev/null 2>&1
    export GPG_TTY=$(tty)
fi

# Set SSH to use gpg-agent if it is configured to do so
GNUPGCONFIG=${GNUPGHOME:-"${XDG_DATA_HOME}/gnupg/gpg-agent.conf"}
if grep -q enable-ssh-support "$GNUPGCONFIG"; then
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK=$GPG_AGENT_SOCKET
fi

### Path ref XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
### Path ref XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
### Path ref XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

### Load pz plugins
PZ_PLUGIN_HOME="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
source $PZ_PLUGIN_HOME/pz/pz.zsh

# source plugins from github
pz source zsh-users/zsh-autosuggestions
pz source zsh-users/zsh-history-substring-search
pz source zsh-users/zsh-completions
pz source zsh-users/zsh-syntax-highlighting
pz source dharma/fast-syntax-highlighting
pz source mattmc3/zsh-xdg-basedirs
pz source mattmc3/zfunctions
pz source mattmc3/zshrc.d
# source ohmyzsh plugins
pz source ohmyzsh/ohmyzsh plugins/sudo
pz source ohmyzsh/ohmyzsh plugins/colored-man-pages
pz source ohmyzsh/ohmyzsh plugins/fzf
pz source ohmyzsh/ohmyzsh plugins/python
pz source ohmyzsh/ohmyzsh plugins/tmux
pz source ohmyzsh/ohmyzsh plugins/command-not-found
pz source ohmyzsh/ohmyzsh plugins/systemd
pz source ohmyzsh/ohmyzsh plugins/zsh_reload
pz source ohmyzsh/ohmyzsh plugins/zsh-interactive-cd
pz source ohmyzsh lib/git
pz source ohmyzsh lib/theme-and-appearance
# set your prompt
pz prompt romkatv/powerlevel10k
#pz prompt sindresorhus/pure

### Added by Zinit's installer
if [[ ! -f ${ZDOTDIR}/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/dotfiles/.zsh/.zinit" && command chmod g-rwX "$HOME/dotfiles/.zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/dotfiles/.zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# zsh-vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# prompt pure
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
### End of Zinit's installer chunk

# pure prompt
#autoload -Uz promptinit
#promptinit
#prompt pure
# optionally define some options
#PURE_CMD_MAX_EXEC_TIME=10
# change the path color
#zstyle :prompt:pure:path color white
# change the color for both `prompt:success` and `prompt:error`
#zstyle ':prompt:pure:prompt:*' color cyan
# turn on git stash status
#zstyle :prompt:pure:git:stash show yes

## Auto Completion - source before this line -------------
autoload -Uz compinit
compinit -i

# Git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

# powerline9k prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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

# Execution time
end=$(date +%s%N)
total=$end-$start
exit_code=$?
echo -e "Loading your blazing fast shell in \e[1;32m$((total/1000000000))\e[0m seconds"
echo ""
