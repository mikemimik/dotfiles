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
# BearNotes
########################################
function new_note() {
    local url="bear://x-callback-url/create"
    local month="$(date "+%b")"
    local day="$(date "+%d")"
    local year="$(date "+%Y")"
    local title="title=${month}%20${day}%2C%20${year}"
    local open_note="open_note=yes"
    local edit="edit=yes"
    local text_tag="%23DevJournal%2Fnpm"
    local text_space="%0A%0A%0A%0A"
    local text_tasks="%23%23%20Tasks${text_space}"
    local text_todos="%23%23%20Todos${text_space}"
    local text_mood="%23%23%20Mood${text_space}"
    local text_forward="%23%23%20Forward"
    local text="text=${text_tag}%0A%0A${text_tasks}${text_todos}${text_mood}${text_forward}%0A"
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
cd() { builtin cd "$@"; clear; ls -alFG; }

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
    d exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it $1 bash
}

docker_exec() {
    container=$1
    shift
    d exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it $container $@
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
