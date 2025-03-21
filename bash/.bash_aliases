#!/usr/bin/env bash

# Set personal aliases, overriding those provided by framework or bash_profile

# NOTE: If autocomplete is needed on an alias, add that alias to
# /usr/local/etc/bash_completion.d/complete-alias

# TERMINAL IMPROVEMENT CONFIGS
COMMON_FLAGS="--color=auto --group-directories-first"
alias ls='gls -ap $COMMON_FLAGS'
alias ll='gls -alp $COMMON_FLAGS'
alias llc='clear && gls -alp $COMMON_FLAGS'
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
alias getloc="pwd | pbcopy"
alias lpath='echo $PATH | tr ":" "\n"'
alias hist="fuzzy_history"
alias where='which'

alias vim="nvim"

alias terminit="rebash; nvm use; clear"
alias hello="ping www.google.ca"

# Brew / Cask aliases
alias cask='brew_cask'
alias brewdeps=brew_dep_graph
alias brwe='brew' #typoes
alias brew=newbrew

# Dotfiles
alias dotfiles=dotfiles
alias rebash="source ~/.bashrc"

# ssh aliases
alias sshlogin=sshlogin

# PERSONAL Computer aliases
alias repos="cd ~/repos"
alias npminc="cd ~/npminc"
alias shopify="cd ~/shopify"

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
alias k="kubectl"
alias kz="kustomize"
alias kcs="kubectl config view -o json | jq -r '.contexts[].name' | ipt | xargs kubectl config use"
alias kc="kubectl config current-context"
alias ek="eksctl"

# Git aliases
alias gs="git status"                                                              # (gs) git staths shorthand
alias gsc="clear && git status"                                                    # (gsc) git status and clear shorthand
alias gc="git commit -m"                                                           # (gc) git commit shorthand
alias gca="git commit --amend"                                                     # (gca) ammend git commit shorthand
alias ga="git add"                                                                 # (ga) git add shorthand
alias gd="fuzzy_git_diff"                                                          # (gd) git diff shorthand
alias gfp="first_git_push"                                                         # (gfp) git first push
alias gr="git restore"                                                             # (gr) git restore
alias grs="git restore --staged"                                                   # (grs) git restore staged
alias fetch="git fetch"                                                            # (fetch) fetch shorthand
alias prune="git fetch --prune"                                                    # (prune) fetch and prune shorthand
alias pull="git pull --ff-only"                                                    # (pull) pull shorthand
alias fpp="fetch && prune && pull"                                                 # (fpp) fetch, prune, pull shorthand
alias fp="fetch && prune"                                                          # (fp) fetch and prune shorthand
alias co="git checkout"                                                            # (co) checkout shorthand
alias unstage="git reset HEAD --"                                                  # (unstage) work/file
alias gl="git log -n 10 --oneline"                                                 # (gl) one line log
alias glf="git log -n 10 --pretty='format:%C(auto)%h %<(1)%C(cyan)%an %C(auto)%s'" # (gl) fancy one line log
alias glp="fuzzy_git_log"
alias gitback="git rebase -i HEAD~15" # interactive rebase last 15 commits
alias wb="git branch -vv"             # (wb) which branch
# GitHub Specific
alias copull="checkout_pull"
## Git interactive aliases
alias gdp="fuzzy_git_diff_pick"
alias wbp="git branch -vv | ipt -u | cut -d ' ' -f 1 | xargs git checkout"
alias gstash="git stash list"
alias gst="gstash"
alias gstashapply="git stash list | ipt -u | cut -d ':' -f 1 | xargs git stash apply --index"
alias gstasha="gstashapply"
alias gsta="gstashapply"
alias gstashshow="git stash list | ipt -u | cut -d ':' -f 1 | xargs git stash show -p"
alias gstashs="gstashshow"
alias gsts="gstashshow"
alias gstashdrop="git stash list | ipt -u | cut -d ':' -f 1 | xargs git stash drop"
alias gstashd="gstashdrop"

# Docker
alias d=docker
alias dc="docker compose"
alias dbash=docker_bash
alias de=docker_exec
alias dsr=docker_stop_and_remove
alias dcl='dc logs -f'
alias dpsa='d ps -a'
alias dps='dpsa --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}"'
alias dpsp='dpsa --format "table {{.Names}}\t{{.Ports}}"'
alias di='d images'
alias dpsjson='dpsa --format "{ \"name\": {{json .Names}}, \"status\": {{json .Status}} }"'
alias dclean='docker images --no-trunc | grep "<none>" | awk '\''{ print $3 }'\'' | gxargs -r docker rmi --force'

# Amazon AWS aliases
alias a=aws
alias aauth=aws-iam-authenticator
alias al=aws_localstack
alias isaws="env | grep ^AWS"

# OpenFaas aliases
alias fast=faas-cli

# Taskwarrior aliases
alias t="task"
alias ta="task add"
alias tad="task add"
alias tan=task_annotate
alias tl="task list"

# BearNotes aliases
alias newnote=new_note

# Tmux aliases
alias tm="tmux"
alias tml="tmux list-sessions"
alias tma=tmux_attach_session
alias tmd=tmux_delete_session
alias tmcs=tmux_create_session
