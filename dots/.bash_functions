#!/bin/bash

## VARIABLES
ARROW="￫"
NC='\033[0m'

########################################
# resolver -ssh
########################################
sshlogin () {
    ACCOUNT=$1
    IP_ADDRESS=$2
    if [ "$#" -ne 2 ]; then
        echo -e "${ARROW} Usage: ${FUNCNAME[0]} account destination${NC}"
        echo
        echo "Example: sshlogin staging 10.10.10.10"
        return 1;
    else
        KEY_PATH="~/.ssh/${ACCOUNT}-keypair.pem"
        ssh -l ec2-user -i ${KEY_PATH} ${IP_ADDRESS}
    fi
}

########################################
# Homebrew
########################################
function brew_cask() {
  brew "$1" --cask "$2"
}

########################################
# Git
########################################
function isRemote() {
    if git remote | grep -q "$1"; then
        true
    else
        false
    fi
}

function isNumber() {
    if echo "$1" | grep -E -q '^[0-9]+$'; then
        true
    else
        false
    fi
}

function checkout_pull() {
    local remote
    local pullNum
    local ref

    local usage=$(cat <<-EOM
${ARROW} Usage: ${FUNCNAME[0]} [remote] | remote pull_number

    Example: ${FUNCNAME[0]} 1235
    Example: ${FUNCNAME[0]} origin 3254
    Example: ${FUNCNAME[0]} upstream 9876
EOM
    )

    case "$#" in
        1)
            remote="origin"
            pullNum="$1"
            ref="pull/${pullNum}/head"

            if isNumber "${pullNum}"; then
                git fetch "${remote}" "${ref}"
                git checkout FETCH_HEAD
            else
                echo -e "pull_number: must be an integer value"
                echo -e "${usage}"
                return 1
            fi
            ;;
        2)
            remote="$1"
            pullNum="$2"
            ref="pull/${pullNum}/head"

            if ! isNumber "${pullNum}"; then
                echo -e "pull_number: must be an integer value"
                echo -e "${usage}"
                return 1
            else
                if ! isRemote "${remote}"; then
                    echo -e "remote: must be a valid git remote"
                    echo -e "${usage}"
                    return 1
                else
                    git fetch "${remote}" "${ref}"
                    git checkout FETCH_HEAD
                fi
            fi
            ;;
        *)
            echo -e "${usage}"
            return 1
            ;;
    esac
}

########################################
# BearNotes
########################################
function new_note() {
    local company="bidvine"
    local url="bear://x-callback-url/create"
    local month="$(date "+%b")"
    local day="$(date "+%d")"
    local year="$(date "+%Y")"
    local title="title=${month}%20${day}%2C%20${year}"
    local open_note="open_note=yes"
    local edit="edit=yes"
    local text_tag="%23DevJournal%2F${company}"
    local text_water="%F0%9F%92%A7x0%0A"
    local text_space="%0A%0A%0A%0A"
    local text_tasks="%23%23%20Tasks${text_space}"
    local text_todos="%23%23%20Todos${text_space}"
    local text_mood="%23%23%20Mood${text_space}"
    local text_forward="%23%23%20Forward"
    local text="text=${text_tag}%0A%0A${text_water}${text_tasks}${text_todos}${text_mood}${text_forward}%0A"
    open "${url}?${title}&${open_note}&${edit}&${text}"
}

########################################
# iterm2
########################################
function iterm2_print_user_vars() {
    iterm2_set_user_var nodeVersion $(node --version)
    iterm2_set_user_var npmVersion $(npm --version)
}

########################################
# system
########################################
strip_color() {
  while read data; do
    gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"
  done
}

cd() {
  builtin cd "$@"
  clear
  gls -alp --color=auto --group-directories-first
}

ql() { qlmanage -p "$*" >& /dev/null; }

random_mac_address() {
    NETWORK_ADAPTER=$1
    if [ "$#" -ne 1 ]; then
        echo -e "${ARRAY} Usage: ${FUNCNAME[0]} network_adapter${NC}"
        echo
        echo "Example: wifimac en0"
        return 1;
    else
        random_mac_address=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
        sudo ifconfig ${NETWORK_ADAPTER} ether ${random_mac_address}
        echo -e "Set MAC address of ${NETWORK_ADAPTER} to: ${random_mac_address}"
    fi
}

brew_dep_graph() {
  tmpfile=$(mktemp /tmp/dotfiles-brew_dep_graph.XXXXXX)
  mv ${tmpfile} ${tmpfile}.png
  brew graph --installed --highlight-leaves | dot -Tpng -o${tmpfile}.png
  open ${tmpfile}.png
}

########################################
# dotfiles
########################################
dotfiles() {
    if [ "$#" -eq 0 ]; then
        cd ~/dotfiles
    else
        dot-cli $@
    fi
}

########################################
# docker
########################################
docker_bash() {
    docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it $1 bash
}

docker_exec() {
    container=$1
    shift
    docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it $container $@
}

docker_stop_and_remove() {
    d stop $1 && d rm $1
}

########################################
# awscli / localstack
########################################
aws_localstack() {
    aws_service=$1
    case $aws_service in
        s3)
            localstack_port=4572
        ;;
	ssm)
	    localstack_port=4583
	;;
        lambda)
            localstack_port=4574
        ;;
        *)
            return 1;
        ;;
    esac
    aws --endpoint-url=http://localhost:$localstack_port $*
}
