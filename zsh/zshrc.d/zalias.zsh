
# zsh only aliases
if [[ -n $ZSH_VERSION ]]; then
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias cd..='cd ..'
alias -g ..2='../..'
alias -g ..3='../../..'
alias -g ..4='../../../..'
alias -g ..5='../../../../..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# sublime text
alias zshrc="vim $ZDOTDIR/.zshrc"
alias zshenv="vim $ZDOTDIR/.zshenv"
alias zlogin="vim $ZDOTDIR/.zlogin"
alias zsprofile="vim $ZDOTDIR/.zprofile"
alias zalias="vim $ZDOTDIR/zshrc.d/zalias.zsh"
alias resolvrc="vim /etc/resolv.conf"
alias wslrc="vim /etc/wsl.conf"
alias tmuxrc="vim $DOTFILES/.tmux.conf"
alias vimrc="vim $DOTFILES/.vimrc"
alias zbench="export LAZY_PROMPT=false; for i in $(seq 1 10); do time 'zsh -i -c exit'; done; unset LAZY_PROMPT"
alias stresscpu="for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done"
alias ompu='sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh && sudo chmod +x /usr/local/bin/oh-my-posh'
alias ompv='oh-my-posh --version'

# zsh pipes
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep -E'
alias -g S='| sort'
alias -g L='| less'
alias -g M='| more'
fi

# mask built-ins with better defaults
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ping="ping -c5 $@"

# be safe
alias cpi='cp -i'
alias mvi='mv -i'
alias rmi='rm -i'

# single character shortcuts - be sparing!
alias _='sudo'
alias c='clear'
alias d='dirs -v | head -10'
alias v='vim'
alias h='history'

# shortcuts
alias vi='vim'
alias nv='nvim'
alias afind='ack -il'
alias md='mkdir -p'
alias rd=rmdir
alias please=sudo
alias po=popd
alias pu=pushd
alias globurl='noglob urlglobber '
alias qq=exit

# network
alias ipext="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias speedtestw="wget -O /dev/null http://speed.transip.nl/10mb.bin"
alias pinging="command ping"

# other aliases
alias tarls="tar -tvf"
alias untar="tar -xf"
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
#alias path='echo -e ${PATH//:/\\n}'
alias linecount="grep -c '^'"
#alias ds="date +%Y%m%d"
alias ts="date +%d%m%Y-%H%M%S"
#alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
#alias datestamp="date '+%Y-%m-%d'"
#alias fd='find . -type d -name'
#alias ff='find . -type f -name'
#alias dud='du -d 1 -h'
#alias duf='du -sh *'
alias dus="du -had 1 | sort -rh"

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"

# ls
alias ld="exa -laD --icons"
alias ll="exa -la --icons --group-directories-first"

# sh
alias ffmpegts="sh -c ~/dotfiles/sh/ffmpegts.sh"

# pass
alias passgp="pass git push -u --all"
alias potp="pass otp $@"
alias pcp="pass -c $@"
alias psh="pass show $@"
alias pins="pass insert -m $@"
alias pgen="pass generate $@"
alias prm="pass rm $@"
alias pfd="pass find $@"
alias pgp="pass grep $@"
alias genpass="head -c 16 /dev/random | base64"

alias myBSN="pass garbage/personal/My/myBSN"
alias 2u="pass garbage/personal/My/Maybank2u"
alias gscudzy="pass garbage/eMail/Google-scudzy"
alias halimi="pass garbage/eMail/Google-halimi@barikatech.com"

# others
alias c="calc $@"
alias suu="sudo apt update && sudo apt upgrade -y && omz update"
alias dfah="df -h $@"
alias dush="du -csh $@"
alias path="printenv | rg $PATH"
alias stats="stat -c '%A %a %n' $@" ### "stat -c '%a' $@"
#alias time="/usr/bin/time -f'Loading in %e secomds' $@"
alias speed="speedtest --selection-details -v"

# windows
alias pwsh="/c/Program\ Files/Powershell/7/pwsh.exe -c $@"
alias cmd="/c/windows/system32/cmd.exe /c $@"
alias powershell="/c/windows/system32/windowspowershell/v1.0/powershell.exe -c $@"
alias choco="/c/ProgramData/chocolatey/bin/choco.exe"
alias fast="cmd /c fast -u"
alias csu="powershell.exe -Command { choco upgrade all -y; sudo scoop update; sudo scoop status }"

# nohup
alias noxterm="nohup xfce4-terminal >/dev/null 2>&1 & sleep 3s"
alias nothun="nohup thunar >/dev/null 2>&1 & sleep 3s"
alias noqt="nohup qtpass >/dev/null 2>&1 & sleep 3s"
#alias mff="flatpak run org.mozilla.firefox"
alias noff="nohup firefox >/dev/null 2>&1 & sleep 3"

# weather
alias wttr="curl -s 'wttr.in/Kuantan?0qTm'"
alias wttr4="curl -s 'wttr.in/Kuantan?format=4'"

# console
alias tio-com3="tio --baudrate 9600 --databits 8 --flow none --stopbits 1 --parity none /dev/tty3"
alias tio-com4="tio --baudrate 9600 --databits 8 --flow none --stopbits 1 --parity none /dev/tty4"
alias tio-com6="tio --baudrate 9600 --databits 8 --flow none --stopbits 1 --parity none /dev/tty6"

# rclone
alias rclGdrvd="rclone --exclude ".git/" sync '/home/scudzy/dotfiles' 'Gdrive:/dotfiles/Debian' --track-renames --checkers=16 --transfers=16 --stats=1s --tpslimit=10 --tpslimit-burst=10 -u -P -v"     # Debian
alias rclGdrvu="rclone --exclude ".git/" sync '/home/scudzy/dotfiles' 'Gdrive:/dotfiles/Ubuntu' --track-renames --checkers=16 --transfers=16 --stats=1s --tpslimit=10 --tpslimit-burst=10 -u -P -v"     # Ubuntu

# python
alias cc="currency_converter $@"
alias vw="pyvoc -w $@"
alias pip="pip3"
alias pip3i="python3 -m pip install $@"
alias pip3u="pip3 uninstall $#"
alias p3="python3"
alias pyupg="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"  # Ubuntu
#alias pyupg="python3 -m pip freeze --local |sed -rn 's/^([^=# \t\\][^ \t=]*)=.*/echo; echo Processing \1 ...; python3 -m pip install -U \1/p' |sh"  @ debian

# apt & dpkg
alias apti="sudo apt install $@"
alias aptinir="sudo apt install --no-install-recommends $@"
alias aptar="sudo apt autoremove $@"
alias aptcs="apt-cache search '' | sort | cut --delimiter ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}' | xargs -r"
alias apts="apt search $@"
alias dpigs20="dpigs --lines=20 -SH"

# fzf
alias fzfb="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# geo location ip
alias ipgeo="curl -s http://ip-api.com/json/ | jq && curl -s http://wehth53mda2rrq7ui08v2w7dzupzfgy6.edns.ip-api.com/json | jq"
alias geoloc="curl -s --request GET --url https://freegeoip.app/json/ --header 'accept: application/json' --header 'content-type: application/json' | jq "

# path
alias dot="cd $DOTFILES"
alias zz="cd $ZDOTDIR"
alias timezsh="time-n-cmd 5 'zsh -i -c exit' 2>&1 > /dev/null"

# git
alias gst="git status"
alias gp="git push"
alias gitlg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lg="lazygit"
alias gcm="git commit -m $@"
alias rmgitd="find . -type d -name ".git" -exec rm -rf {} +"

# terminal
alias term-size='echo "Rows=$(tput lines) Cols=$(tput cols)"'

# Trash
alias del="trash-put $@"
alias tempty="trash-empty $@"
alias trestore="restore-trash $@"
alias tlist="trash-list"
alias cat="bat --pager"
alias tl="tldr $@"

# dns
alias dns1='echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8\n" | sudo tee /etc/resolv.conf'
alias dns8="echo nameserver 8.8.8.8 | sudo tee -a /etc/resolv.conf"

# others
alias ipa="ip address show eth0"
alias gduns="gdu -ns --si $@"
alias gduna="gdu -na --si $@"
alias rmrf="rm -rfv $@"
alias s256="sha256sum $@"
alias rld="omz reload"
alias gpgpwd="gpg --gen-random --armor 1 8"

# bat alias
alias bwsl="bat /etc/wsl.conf"
alias bresolv="bat /etc/resolv.conf"
alias bgenie="bat /etc/genie.ini"

# sed
alias sedhtml="sed 's/<\/*[^>]*>//g'"
alias encode="openssl enc -base64 <<< $@"
alias decode="openssl enc -base64 -d <<< $@"

# brew
alias brewuu="brew update && brew upgrade && exec zsh"
alias brewup="brew upgrade $@"
alias brewl="brew list"
alias brewi="brew install $@"
alias brewun="brew uninstall $@"
