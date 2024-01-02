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

# Set path
DOTFILES="$HOME/.dotfiles"
ZDOTDIR="$HOME/.dotfiles/zsh"

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
bindkey '^Xh' _complete_help                      # ctrl x h context for a command

# ### zsh builtin AUTOLOAD
# autoload -Uz compinit
# compinit -i
# (( ${+_comps} )) && _comps[zinit]=_zinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
    [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# # ensure compinit recognizes zinit's changes
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# shellcheck disable=SC2154
# autoload -Uz compinit
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

# History configurations
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
    if [ -f $HOME/.local/share/zinit/plugins/zsh-users---zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . $HOME/.local/share/zinit/plugins/zsh-users---zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
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
if [ -f $HOME/.local/share/zinit/plugins/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . $HOME/.local/share/zinit/plugins/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh
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

### Turbo mode
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
        blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
        OMZP::tmux \
        OMZP::genpass \
        OMZP::fzf \
        OMZP::sudo \
        OMZP::command-not-found \
        OMZP::colored-man-pages \
        OMZP::python \
        OMZP::systemd \
        OMZP::zsh-interactive-cd \
        OMZP::encode64 \
        OMZP::systemadmin \
        OMZP::gpg-agent \
        OMZP::docker-compose \
        OMZP::debian \
        OMZP::svn \
        OMZP::snap

# declare-zsh
zinit ice wait lucid
zinit load zdharma-continuum/declare-zsh

# async support
zinit ice wait lucid \
  atload"async_init" \
  src"async.zsh"
zinit light mafredri/zsh-async

# zsh better npm completion
zinit ice wait lucid src"zsh-better-npm-completion.plugin.zsh"
zinit load lukechilds/zsh-better-npm-completion

### zsh-users/zsh-history-substring-search
# history substring searching
# only bind these keys once they're ready
bindkey -r "^[[A"
bindkey -r "^[[B"
zinit ice wait lucid \
  atload"
    zmodload zsh/terminfo
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

### zdharma-continuum/history-search-multi-word
zinit ice wait"1" lucid
zinit load zdharma-continuum/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"

### diff-so-fancy
zinit ice wait"1" lucid as"program" pick"bin/git-dsf"
zinit load zdharma-continuum/zsh-diff-so-fancy

### sharkdp/fd
zinit ice lucid wait"1" as"command" from"gh-r" mv"fd* -> fd" \
    atclone"
    mv -vf fd*/autocomplete/_fd _fd
    mv -vf fd*/fd.1 ${ZINIT[MAN_DIR]}/man1"
zinit light sharkdp/fd

### vivid
zinit ice lucid wait"1" as"command" from"gh-r" mv"vivid* -> vivid" \
    atload'export LS_COLORS="$(vivid generate snazzy)"'
zinit light sharkdp/vivid

### sharkdp/bat
zinit ice lucid wait"1" as"command" from"gh-r" mv"bat* -> bat" \
  atclone"
    mv -vf bat*/autocomplete/bat.zsh _bat
    mv -vf bat*/bat.1 ${ZINIT[MAN_DIR]}/man1" \
  atload"
    export BAT_THEME='zenburn'
    export BAT_PAGER='less -R -F -+X --mouse'
    export PAGER='less'
    export MANPAGER='sh -c \"col -bx | bat --color=always --style=plain --language=man\"'"
zinit light sharkdp/bat

### ogham/exa, replacement for ls
# zinit ice wait"2" lucid from"gh-r" as"program" mv"bin/exa* -> exa" pick"exa" \
# rm -rf man bin completions
zinit ice wait"2" lucid from"gh-r" as"program" pick"bin/exa" \
    cp"completions/exa.zsh _exa" \
    cp"man/exa.1 ${ZINIT[MAN_DIR]}/man1" \
    cp"man/exa_colors.5 ${ZINIT[MAN_DIR]}/man5"
zinit light ogham/exa

### All of the above using the for-syntax and also z-a-bin-gem-node annex
zinit wait"1" lucid from"gh-r" as"null" for \
    sbin"**/fd"            @sharkdp/fd \
    sbin"**/vivid"         @sharkdp/vivid \
    sbin"**/bat"           @sharkdp/bat

zinit ice wait"1" lucid as"command" from"gh-r" mv"hyperfine*/hyperfine -> hyperfine" \
    atclone"
    mv -vf hyperfine*/autocomplete/_hyperfine _hyperfine
    mv -vf hyperfine*/*.1  ${ZINIT[MAN_DIR]}/man1
    rm -rfv hyperfine-*" pick"hyperfine"
zinit light sharkdp/hyperfine

### omz lib multisource
zinit ice svn pick"completion.zsh" multisrc"git.zsh functions.zsh \
    clipboard.zsh cli.zsh history.zsh completion.zsh termsupport.zsh"
zinit snippet OMZ::lib

# ### omz git
# zinit ice wait lucid
# zinit snippet OMZL::git.zsh
zinit ice wait atload"unalias grv" lucid
zinit snippet OMZP::git

# BurntSushi/ripgrep
zinit ice lucid as"command" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg" \
    atclone"
        mv -vf rg/doc/rg.1 ${ZINIT[MAN_DIR]}/man1"
zinit light BurntSushi/ripgrep

### git-delta delta-0.16.5-x86_64-unknown-linux-musl.tar.gz
zinit ice wait from"gh-r" as"command" mv"delta-* -> delta" pick"delta/delta" \
  dl="https://github.com/dandavison/delta/raw/HEAD/etc/completion/completion.zsh -> _delta"
zinit light dandavison/delta

### Install z.lua
zinit ice wait'!0'
zinit light skywind3000/z.lua

### b4b4r07/httpstat
zinit ice lucid wait as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zinit light b4b4r07/httpstat

### dalance/procs
zinit ice lucid wait as"command" from"gh-r" bpick"*x86_64-linux*" pick"procs"
zinit light dalance/procs

### oxipng
zinit ice lucid wait as"command" from"gh-r" bpick"*x86_64-unknown-linux*" mv"oxipng* -> oxipng" pick"oxipng/oxipng"
zinit light shssoichiro/oxipng

### dbrgn/tealdeer
zinit ice lucid wait from"gh-r" as"command" \
    mv"tealdeer* -> tldr" \
    dl="https://raw.githubusercontent.com/dbrgn/tealdeer/main/completion/zsh_tealdeer -> _tldr"
zinit light dbrgn/tealdeer

### charmbracelet/glow
zinit ice lucid wait from"gh-r" as"command" bpick"*_linux_x86_64.tar.gz" pick"glow" \
  cp"completions/glow.zsh -> _glow"
zinit light charmbracelet/glow

### Load fzf, completion & key biindings
zinit for \
    as'command' \
    dl="https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh" \
    dl="https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf" \
    dl="https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1" \
    dl="https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1" \
    from'gh-r' \
    null \
    pick'fzf' \
    src'key-bindings.zsh' \
    atclone"
    mv -vf *.1 ${ZINIT[MAN_DIR]}/man1
    " \
  @junegunn/fzf

### tab completions via fzf-tab
zinit ice wait"1" lucid \
  has"fzf" \
  atload"
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion::complete:*:*:files' ignored-patterns '.DS_Store' 'Icon?' '.Trash'
    zstyle ':completion::complete:*:*:globbed-files' ignored-patterns '.DS_Store' 'Icon?' '.Trash'
    zstyle ':completion::complete:rm:*:globbed-files' ignored-patterns
    zstyle ':fzf-tab:*' fzf-command fzf
    zstyle ':fzf-tab:*' fzf-flags '--ansi'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:_zlua:*' query-string input
    zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    zstyle ':fzf-tab:*' fzf-bindings \
      'tab:accept' \
      'ctrl-y:preview-page-up' \
      'ctrl-v:preview-page-down' \
      'ctrl-e:execute-silent(\${VISUAL:-code} \$realpath >/dev/null 2>&1)' \
      'ctrl-w:execute(\${EDITOR:-nano} \$realpath >/dev/tty </dev/tty)+refresh-preview'
    zstyle ':fzf-tab:*' fzf-min-height 15
    zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
      'git diff --no-ext-diff \$word | delta --paging=never --no-gitconfig --line-numbers --file-style=omit --hunk-header-style=omit --theme=base16'
    zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
      'git --no-pager log --color=always --format=oneline --abbrev-commit --follow \$word'
    zstyle ':fzf-tab:complete:man:*' fzf-preview \
      'man -P \"col -bx\" \$word | $FZF_PREVIEW_FILE_COMMAND --language=man'
    zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview \
      'brew info \$word'
    zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview \
      'echo \${(P)word}'
    zstyle ':fzf-tab:complete:*:options' fzf-preview
    zstyle ':fzf-tab:complete:*:options' fzf-flags '--no-preview'
    zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
    zstyle ':fzf-tab:complete:*:argument-1' fzf-flags '--no-preview'
    zstyle ':fzf-tab:complete:*:*' fzf-preview \
      '($FZF_PREVIEW_FILE_COMMAND \$realpath || $FZF_PREVIEW_DIR_COMMAND \$realpath) 2>/dev/null'
  "
zinit light Aloxaf/fzf-tab

### LS_COLORS Download the default profile
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

### clone vim & compiling
zinit ice \
    as"program" \
    atclone"
        rm -f src/auto/config.cache; 
        ./configure --with-features=huge --enable-gui=gtk3 --enable-cscope --with-x --enable-multibyte --enable-rubyinterp=yes --enable-perlinterp=yes --enable-python3interp=yes --with-python3-command=/usr/bin/python3 --with-python3-config-dir=/usr/lib/python3.11/config-3.11-x86_64-linux-gnu/ --enable-luainterp=yes --with-compiledby='scudzy@duck.com'" \
    atpull"%atclone" \
    make \
    pick"src/vim" \
    atload"
        sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 10;
        sudo update-alternatives --set editor /usr/local/bin/vim" #make pick"src/vim"
zinit light vim/vim

### A more intuitive version of du in rust 
zinit ice lucid wait as"command" from"gh-r" mv"dust*x86_64*linux-gnu/dust -> dust" bpick"dust*x86_64*linux-gnu*" pick"dust" \
    dl="https://raw.githubusercontent.com/bootandy/dust/master/completions/_dust" \
    dl="https://raw.githubusercontent.com/bootandy/dust/master/man-page/dust.1" \
    atclone"
    mv -vf *.1 ${ZINIT[MAN_DIR]}/man1
    rm -rfv dust-*"
zinit light bootandy/dust

### git extras
zinit lucid wait'0a' for \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" \
    make"PREFIX=$ZPFX" tj/git-extras

### FZF configs ------------- ###
export FZF_BASE="$HOME/.local/share/zinit/plugins/junegunn---fzf"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --color=always"

# Color Ayu Mirage
export FZF_DEFAULT_OPTS="
    --height=60% --layout=reverse
    --inline-info --border --margin=1 --padding=1
    --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
    --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
    --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
    --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff"

export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"

## Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

## only for git
zstyle ':completion:*:*:git:*' fzf-search-display true
## or for everything
zstyle ':completion:*' fzf-search-display true

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

### Load forgit as the last one before prompt
### forgit
zinit ice wait lucid \
    atload'export forgit_revert_commit="grcm"'
zinit load wfxr/forgit 

####################### Start of p10k prompt line ##########################

# # After finishing the configuration wizard change the atload'' ice to:
# # -> atload'source ~/.p10k.zsh; _p9k_precmd'
# zinit ice depth"1" atload'true; _p9k_precmd' nocd
zinit ice depth"1" atload'source $ZDOTDIR/.p10k.zsh; _p9k_precmd' nocd
zinit light romkatv/powerlevel10k

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
(( ! ${+functions[p10k]} )) || p10k finalize
####################### End of p10k prompt line ############################

####################### Start of pure prompt line ##########################

# # pure prompt
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# zstyle :prompt:pure:prompt:success color 014
# zstyle :prompt:pure:host color 014

# # Load pure theme
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# # pure dark theme
# typeset -A pure_halloween_scheme=(
#     color1 "#E84000" # Tangelo
#     color2 "#EB6123" # Halloween Orange
#     color3 "#FFE5D5" # Flesh
#     color4 "#F1B111" # Spanish Yellow
#     color5 "#FF1A72" # Electric Pink
#     color6 "#E40055" # Raspberry
# )

# zstyle :prompt:pure:execution_time      color $pure_halloween_scheme[color3]
# zstyle :prompt:pure:git:arrow           color $pure_halloween_scheme[color5]
# zstyle :prompt:pure:git:branch          color $pure_halloween_scheme[color2]
# zstyle :prompt:pure:git:branch:cached   color $pure_halloween_scheme[color1]
# zstyle :prompt:pure:git:dirty           color $pure_halloween_scheme[color4]
# zstyle :prompt:pure:host                color $pure_halloween_scheme[color6]
# zstyle :prompt:pure:path                color $pure_halloween_scheme[color1]
# zstyle :prompt:pure:prompt:error        color $pure_halloween_scheme[color1]
# zstyle :prompt:pure:prompt:success      color $pure_halloween_scheme[color4]
# zstyle :prompt:pure:user                color $pure_halloween_scheme[color4]
# zstyle :prompt:pure:user:root           color $pure_halloween_scheme[color3]
# zstyle :prompt:pure:virtualenv          color $pure_halloween_scheme[color6]

# ### Load pure prompt
# autoload -U promptinit; promptinit
# prompt pure

####################### End of pure prompt line #############################

####################### Start of starship prompt line ##########################

# # starship prompt
# if ! command -v starship >/dev/null 2>&1; then
#   if which wget >/dev/null ; then
#     echo "Downloading via wget"
#     wget https://starship.rs/install.sh
#   elif which curl >/dev/null ; then
#     echo "Downloading via curl"
#     curl -sS -O https://starship.rs/install.sh
#   else
#     echo "Cannot download, neither wget nor curl. Exiting"
#     exit 1
#   fi
# fi

# # starship prompt
# zinit ice from"gh-r" as"command" \
#   atclone"
#     ./starship init zsh --print-full-init > init.zsh
#     ./starship completions zsh > _starship
#   " \
#   atpull"%atclone" \
#   src"init.zsh"
# zinit light starship/starship

# SPACESHIP_PROMPT_ORDER=(
#   user          # Username section
#   dir           # Current directory section
#   host          # Hostname section
#   git           # Git section (git_branch + git_status)
#   hg            # Mercurial section (hg_branch  + hg_status)
#   exec_time     # Execution time
#   line_sep      # Line break
#   vi_mode       # Vi-mode indicator
#   jobs          # Background jobs indicator
#   exit_code     # Exit code section
#   char          # Prompt character
# )
# SPACESHIP_USER_SHOW=always
# SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_CHAR_SYMBOL="❯"
# SPACESHIP_CHAR_SUFFIX=" "

### starship prompt
# zinit ice from"gh-r" as"command" \
#   atload"./starship init zsh --print-full-init > init.zsh"
# zinit light starship/starship
# eval "$(starship init zsh)"
# zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
# zinit load starship/starship

####################### End of starship prompt line ##########################

# zinit wait lucid light-mode for \
#     atinit"
#     dl="https://raw.githubusercontent.com/simplonco/oh-my-zsh/master/plugins/emoji/emoji-char-definitions.zsh" \
#     dl="https://raw.githubusercontent.com/simplonco/oh-my-zsh/master/plugins/emoji/emoji-data.txt" \
#     dl="https://raw.githubusercontent.com/simplonco/oh-my-zsh/master/plugins/emoji/update_emoji.pl"
#     "
# zinit snippet OMZP::emoji

### nvm lazy loads
zstyle ':omz:plugins:nvm' lazy yes
########################## End of zinit line #############################

# fix mkdir permission
if grep -q microsoft /proc/version; then
    if [ "$(umask)" == '0000' ]; then
        umask 0022
    fi
fi

# Checking Login v.s. Non-Login
if [[ -o Login ]]; then
    echo "Login" && neofetch
else
    echo "Non-Login" && fortune linux | cowsay -f tux
fi

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
unalias z 2> /dev/null
z() {
   [ $# -gt 0 ] && _z "$*" && return
   cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

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

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}

### nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# place this after nvm initialization!
# autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

# add-zsh-hook chpwd load-nvmrc
load-nvmrc

# powerline-status
$HOME/.local/pipx/venvs/powerline-status/bin/powerline-daemon -q
. "$HOME/.local/pipx/venvs/powerline-status/lib/python3.11/site-packages/powerline/bindings/zsh/powerline.zsh"

### source xdg settings
[[ -f '$ZDOTDIR/xdg.zsh' ]] || source $ZDOTDIR/xdg.zsh
[[ -f '$ZDOTDIR/function.zsh' ]] || source $ZDOTDIR/function.zsh
# source zalias
[[ -f '$ZDOTDIR/.zalias' ]] || source $ZDOTDIR/.zalias

### the fuck alias
eval "$(thefuck --alias)"
#eval $(thefuck --alias --enable-experimental-instant-mode)

### ruby env
# eval "$(rbenv init - --no-rehash zsh)"
# source rbenv
# [[ -f '~/.rbenv/completions/rbenv.zsh' ]] || source ~/.rbenv/completions/rbenv.zsh

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

### Auto Completion -------------- SOURCE BEFORE THIS LINE

### Git prompt
# autoload -Uz vcs_info
# precmd() { vcs_info }
# zstyle ':vcs_info:git:*' formats '%F{153}%b%f'
# PROMPT='%(?.%F{green}●.%F{red}●%f) %F{211}%1~%f ${vcs_info_msg_0_} '
# RPROMPT='%F{245}%*%f'

# p10k env var
POWERLEVEL9K_DISABLE_GITSTATUS="true"
GITSTATUS_DAEMON="${HOME}/.local/share/zinit/plugins/romkatv---powerlevel10k/gitstatus/usrbin/gitstatusd"
GITSTATUS_LOG_LEVEL=DEBUG

#####################
# COLORING          #
#####################
autoload colors && colors

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

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
# neofetch
#fortune linux | cowsay -f tux
echo ""
printf "\e[0;97m 💠 Loading your blazing 🚀 fast ⚡ shell in\e[39m \e[1;92;5m$total\e[0m 🔥 \e[0;97mseconds 👻 \e[0m\n"
echo ""

# debug
# zprof
