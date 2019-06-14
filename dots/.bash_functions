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
# system
########################################
cd() { builtin cd "$@"; clear; ls -alFG; }

ql() { qlmanage -p "$*" >& /dev/null; }

random_mac_address() {
    NETWORK_ADAPTER=$1
    if [ "$#" -ne 1 ]; then
        echo -e "${ARRAY} USage: ${FUNCNAME[0]} network_addapter${NC}"
        echo
        echo "Example: wifimac en0"
        return 1;
    else
        random_mac_address=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
        sudo ifconfig ${NETWORK_ADAPTER} ether ${random_mac_address}
        echo -e "Set MAC address of ${NETWORK_ADAPTER} to: ${random_mac_address}"
    fi
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
