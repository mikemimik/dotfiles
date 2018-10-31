#!/bin/bash

cd() { builtin cd "$@"; clear; ls -alFG; }

ql() { qlmanage -p "$*" >& /dev/null; }

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
