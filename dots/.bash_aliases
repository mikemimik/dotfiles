# Set personal aliases, overriding those provided by framework or bash_profile

# TERMINAL IMPROVEMENT CONFIGS
alias ls='ls -aFG'
alias ll='ls -alFG'
alias llc='clear && ls -alFG'
alias lsd='ls -l | grep "^d" --color'
alias howbig='du -skh'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias ~='cd ~'
alias f='open -a Finder ./'
alias c='clear'
alias cat='bat'

# Brew / Cask aliases
alias cask='brew cask'
alias where='which'
alias brwe='brew' #typoes
alias brewdeps=brew_dep_graph

# Dotfiles
alias dotfiles=dotfiles
alias rebash="source ~/.bashrc"

# RESOLVER aliases
alias r='rslv'
alias sshlogin=sshlogin

## Resolver repositories
alias core-services="cd /Code/core-services"
alias core-client="cd /Code/core-client"
alias core-packages="cd /Code/npm-packages"
alias resolver-cli="cd /Code/dev-tooling/resolver-cli"
alias fdc="cd /Code/dev-tooling/fdc"
alias concourse-lax="cd /Code/dev-tooling/concourse-lax"
alias ops-cli="cd /Code/dev-tooling/ops-cli"
alias resolver-server-common="cd /Code/npm-packages/modules/resolver-server-common"
alias resolver-data-client="cd /Code/npm-packages/clients/resolver-data-client"
alias resolver-user-client="cd /Code/npm-packages/clients/resolver-user-client"
alias resolver-object-client="cd /Code/npm-packages/clients/resolver-object-client"
alias resolver-config="cd /Code/npm-packages/modules/resolver-config"

# PERSONAL Computer aliases
alias repos="cd ~/repos"
alias npminc="cd ~/npminc"

# Networking aliases
alias flushdns="sudo dscacheutil -flushcache"
alias flushdnshard="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias getip="curl icanhazip.com"

# Show/hide all desktop icons (useful when presenting)
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

# Show/hide hidden files/folders
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidehiddenfiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

# restart macOS camera
alias killcamera="sudo killall AppleCameraAssistant; sudo killall VDCAssistant"

# randomise wifi MAC address
alias randommac=random_mac_address

# NPM aliases
alias npmglist="npm list -g --depth=0"

# Gatsby aliases
alias gat=gatsby

# Terraform aliases
alias tf=terraform

# Kubernetes aliases
alias k=kubectl

# Git aliases
alias gs="git status"               # (gs) git staths shorthand
alias gsc="clear && git status"     # (gsc) git status and clear shorthand
alias gc="git commit -m"            # (gc) git commit shorthand
alias gca="git commit --amend"      # (gca) ammend git commit shorthand
alias ga="git add"                  # (ga) git add shorthand
alias gd="git diff"                 # (gd) git diff shorthand
alias fetch="git fetch"             # (fetch) fetch shorthand
alias prune="git fetch --prune"     # (prune) fetch and prune shorthand
alias pull="git pull"               # (pull) pull shorthand
alias fpp="fetch && prune && pull"  # (fpp) fetch, prune, pull shorthand
alias fp="fetch && prune"           # (fp) fetch and prune shorthand
alias co="git checkout"             # (co) checkout shorthand
alias unstage="git reset HEAD --"   # (unstage) work/file
alias gl="git log --oneline"        # (gl) one line log
alias wb="git branch -vv"           # (wb) which branch
## Git interactive aliases
alias gdp="git status -s | ipt -p -a | xargs git diff"

# Docker
alias d=docker
alias dc=docker-compose
alias dbash=docker_bash
alias de=docker_exec
alias dsr=docker_stop_and_remove
alias dcl='dc logs -f'
alias dpsa='d ps -a'
alias dps='dpsa --format "table {{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}"'
alias dpsp='dpsa --format "table {{.Names}}\t{{.Ports}}"'
alias di='d images'
alias dpsjson='dpsa --format "{ \"name\": {{json .Names}}, \"status\": {{json .Status}} }"'
alias dclean='docker images --no-trunc | grep "<none>" | awk '\''{ print $3 }'\'' | gxargs -r docker rmi --force'

# Amazon AWS aliases
alias a=aws
alias aauth=aws-iam-authenticator
alias al=aws_localstack

# OpenFaas aliases
alias fast=faas-cli

# Taskbook aliases
alias task=tb

# BearNotes aliases
alias newnote=new_note
