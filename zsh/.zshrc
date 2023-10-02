start="$(date +%s)"
# module_path+=( "/home/scudzy/.local/share/zinit/module/Src" )
# zmodload zsh/zprof
# zmodload -i zsh/complist

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd               # change directory just by typing its name
#setopt correct             # auto correct mistakes
setopt auto_list            # automatically list choices on ambiguous completion
setopt auto_menu            # automatically use menu completion
setopt always_to_end        # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances
setopt correct_all          # autocorrect commands
setopt interactivecomments  # allow comments in interactive mode
setopt magicequalsubst      # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch            # hide error message if there is no match for the pattern
setopt notify               # report the status of background jobs immediately
setopt numericglobsort      # sort filenames numerically when it makes sense
setopt nohup                # for nohup to works against watch
setopt promptsubst          # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
    [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# enable completion features

# autoload -Uz compinit
# if [[ -n $HOME/.cache/zsh/zcompdump-$ZSH_VERSION(#qN.mh+24) ]]; then
# compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
# else
# compinit -C;
# fi

# autoload -Uz compinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
# compinit -i

autoload -Uz compinit
compinit -d ~/.cache/zcompdump
# compinit -i

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-descitiption 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ## only for git
# zstyle ':completion:*:*:git:*' fzf-search-display true
# ## or for everything
# zstyle ':completion:*' fzf-search-display true

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Ctrl+A for aliases full commands
zle -C alias-expension complete-word _generic
bindkey '^a' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    prompt_symbol=㉿
    # Skull emoji for root terminal
    #[ "$EUID" -eq 0 ] && prompt_symbol=💀
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            # Right-side prompt with exit codes and background rocesses
            #RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
        ;;
        oneline)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
        ;;
        backtrack)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
        ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white,underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
        TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
    *)
    ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    # add color to man pages
    export MANROFFOPT='-c'
    export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
    export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
    export LESS_TERMCAP_me=$(tput sgr0)
    export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
    export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
    export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
    export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### Zinit
### Turbo mode
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
        OMZP::colored-man-pages \
        OMZP::tmux \
        OMZP::genpass \
        OMZP::fzf \
        OMZP::sudo \
        OMZP::command-not-found \
        OMZP::python \
        OMZP::systemd \
        OMZP::zsh-interactive-cd \
        OMZP::encode64 \
        OMZP::systemadmin \
        OMZP::brew \
        OMZP::gpg-agent \
        OMZP::docker-compose \
        OMZP::debian

# zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-history-substring-search

# zdharma-continuum/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"
zinit ice wait"1" lucid
zinit load zdharma-continuum/history-search-multi-word

# diff-so-fancy
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma-continuum/zsh-diff-so-fancy

### omz git
zinit ice atload"unalias grv"
zinit snippet OMZP::git

### omz lib
zinit ice svn pick"completion.zsh" src"git.zsh"
zinit snippet OMZ::lib

# Source omz lib
# zinit snippet OMZL::clipboard.zsh
# zinit snippet OMZL::cli.zsh
# zinit snippet OMZL::functions.zsh
# zinit snippet OMZL::history.zsh
# zinit snippet OMZL::completion.zsh
# zinit snippet OMZL::termsupport.zsh

zinit for OMZL::prompt_info_functions.zsh OMZT::gnzh

# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# ogham/exa, replacement for ls
zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa

# All of the above using the for-syntax and also z-a-bin-gem-node annex
zinit wait"1" lucid from"gh-r" as"null" for \
    sbin"**/fd"        @sharkdp/fd \
    sbin"**/bat"       @sharkdp/bat \
    sbin"exa* -> exa"  ogham/exa

# forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# ripgrep
zinit ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

# git-delta
zinit ice as"command" from"gh-r" mv"*x86_64-unknown-linux-musl/delta -> delta" bpick"*x86_64-unknown-linux-musl*" pick"delta"
zinit light dandavison/delta

### Install z.lua
zinit ice wait'!0'
zinit light skywind3000/z.lua

# b4b4r07/httpstat
zinit ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zinit light b4b4r07/httpstat

# dalance/procs
zinit ice as"command" from"gh-r" bpick"*x86_64-linux*" pick"procs"
zinit light dalance/procs

# dbrgn/tealdeer
zinit ice as"command" from"gh-r" mv"tealdeer* -> tldr" bpick"tealdeer-linux-x86_64-musl" pick"dbrgn/tealdeer"
zinit light dbrgn/tealdeer

# charmbracelet/glow
zinit ice as"command" from"gh-r" bpick"*_linux_x86_64.tar.gz" pick"glow"
zinit light charmbracelet/glow

### docker completion
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

### LS_COLOR
# zinit ice wait"0c" lucid reset \
#     atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
#     \${P}sed -i \
#     '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
#     \${P}dircolors -b LS_COLORS > c.zsh" \
#     atpull'%atclone' pick"c.zsh" nocompile'!' \
#     atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
# zinit light trapd00r/LS_COLORS

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

### Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# autoload -Uz compinit
# compinit -d ~/.cache/zcompdump

####################### End of zinit line ##########################

# ### tmux window name
# tmux-window-name() {
# (~/.tmux/plugins/tmux-window-name/scripts/rename_session_windows.py &)
# }
# add-zsh-hook chpwd tmux-window-name

# fix mkdir permission
if grep -q microsoft /proc/version; then
    if [ "$(umask)" == '0000' ]; then
        umask 0022
    fi
fi

# after `forgit` was loaded
export forgit_revert_commit="grcm"

# Set path
export DOTFILES=~"/.dotfiles"
export ZDOTDIR=~"/.dotfiles/zsh"
export PATH="${HOME}/.local/bin:${HOME}/.dotfiles/sh:$PATH"
## ${HOME}/.local/share/zinit/plugins/wfxr---forgit/bin

# powerline9k prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# source zalias
source /home/scudzy/.dotfiles/zsh/.zalias

# source gcloud completion
#source /snap/google-cloud-cli/current/completion.zsh.inc

# zsh-interactive-cd
source /home/scudzy/.local/share/zinit/snippets/OMZP::zsh-interactive-cd/OMZP::zsh-interactive-cd

# Checking Login v.s. Non-Login
[[ -o login ]] && echo "Login" || echo "Non-Login"

# grc
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
# dynamic aliases
for cmd in g++ gas head make ld ping6 tail traceroute6 $( ls /usr/share/grc/ ); do
    cmd="${cmd##*conf.}"
    type "${cmd}" >/dev/null 2>&1 && alias "${cmd}"="$( which grc ) --colour=auto ${cmd}"
done

# xterm modes
if [ "$TERM" != "xterm-256color" ]; then
    export TERM=xterm-256color
fi

### FZF configs ------------- ###
### fzf env var
# source zsh fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE="~/.fzf/"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --color=always"

# Color Ayu Mirage
export FZF_DEFAULT_OPTS="
    --height=50% --layout=reverse
    --inline-info --border --margin=1 --padding=1
    --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
    --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
    --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
    --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff"

# export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --inline-info --border --margin=1 --padding=1"
# export FZF_CTRL_R_OPTS="--height=50% --border=sharp --layout=reverse --prompt '∷ ' --pointer=▶ --marker=⇒"
export FZF_CTRL_T_OPTS="--height=50% --border=sharp --layout=reverse --prompt '∷ ' --pointer=▶ --marker=⇒"
# export FZF_DEFAULT_OPTS='--reverse --border --exact --height=50%'

export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"

# ## Preview file content using bat (https://github.com/sharkdp/bat)
# export FZF_CTRL_T_OPTS="
#     --preview 'bat -n --color=always {}'
#     --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# export FZF_ALT_C_COMMAND="fd --type directory"
# # Print tree structure in the preview window
# export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

### Options to fzf command
export FZF_COMPLETION_OPTS="--border --info=inline"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# basic file preview for ls (you can replace with something more sophisticated than head)
zstyle ':completion::*:ls::*' fzf-completion-opts --preview='eval head {1}'

# preview when completing env vars (note: only works for exported variables)
# eval twice, first to unescape the string, second to expand the $variable
zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo {1}'

# preview a `git status` when completing git add
zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='git -c color.status=always status --short'

# if other subcommand to git is given, show a git diff or git log
zstyle ':completion::*:git::*,[a-z]*' fzf-completion-opts --preview='
eval set -- {+1}
for arg in "$@"; do
    { git diff --color=always -- "$arg" | git log --color=always "$arg" } 2>/dev/null
done'

### End of fzf configs ----------------------- ###

### fzf pass ZSH
_fzf_complete_pass() {
  _fzf_complete +m -- "$@" < <(
    local prefix
    prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
    command find -L "$prefix" \
      -name "*.gpg" -type f | \
      sed -e "s#${prefix}/\{0,1\}##" -e 's#\.gpg##' -e 's#\\#\\\\#' | sort
  )
}

### fzf integration with z.lua
#unalias z 2> /dev/null
#z() {
#    [ $# -gt 0 ] && _z "$*" && return
#    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
#}

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

# powerline-status
/home/scudzy/.local/pipx/venvs/powerline-status/bin/powerline-daemon -q
source ~/.local/pipx/venvs/powerline-status/lib/python3.11/site-packages/powerline/bindings/zsh/powerline.zsh

# Load z.lua
#eval "$(lua ~/z.lua-1.8.12/z.lua --init zsh)"
eval "$(lua ~/.dotfiles/z.lua/z.lua --init zsh enhanced once fzf)"

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}

# man color view in bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Windows Terminal
function settitle () {
  export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
  echo -ne '\033]0;'"$1"'\a'
}

# browserpass gnupg
PIDFOUND=$(pgrep gpg-agent)
if [ -n "$PIDFOUND" ]; then
    export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:$PIDFOUND:1"
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
    unset SSH_AGENT_PID
fi
PIDFOUND=$(pgrep dirmngr)
if [ -n "$PIDFOUND" ]; then
    export DIRMNGR_INFO="$HOME/.gnupg/S.dirmngr:$PIDFOUND:1"
fi
unset PIDFOUND

# the fuck alias
eval $(thefuck --alias)
#eval $(thefuck --alias --enable-experimental-instant-mode)

### Load Homebrew env
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Git
autoload -Uz vcs_info
precmd_vcs_info() vcs_info
precmd_functions+=( precmd_vcs_info )
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'
GITSTATUS_LOG_LEVEL=DEBUG

### Auto Completion -------------- SOURCE BEFORE THIS LINE

### zsh builtin AUTOLOAD
autoload -Uz compinit
(( ${+_comps} )) && _comps[zinit]=_zinit
compinit -i

### pipx Completion
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

# # fpath
# # fpath=(~/.local/share/zinit/completions "${fpath[@]}" )
# autoload -Uz $fpath[1]/*(.:t)

### brew shell completions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# fpath
fpath=(
    /home/scudzy/.local/share/zinit/completions
    /home/scudzy/.dotfiles/zsh/functions
    "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# load function folders ----------- NEVER DELETE BELOW RHIS LINE
### End of Zinit's installer chunk

# Execution time
end="$(date +%s)"
total="$(( end - start ))"
neofetch
#fortune linux | cowsay -f tux
echo ""
printf "\e[0;97m 💠 Loading your blazing 🚀 fast ⚡ shell in\e[39m \e[1;92;5m$total\e[0m 🔥 \e[0;97mseconds 👻 \e[0m\n"
echo ""

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh

# debug
# zprof
