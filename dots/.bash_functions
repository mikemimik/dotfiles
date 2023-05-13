#!/bin/bash

## VARIABLES
ARROW="￫"
NC='\033[0m'

########################################
# common
########################################
function errcho(){
  >&2 echo "$@";
}

function promptYesNo() {
  local message=$1
  local response=""

  response=$(echo "yes no" | ipt -u -s " " -M "${message}")

  echo "${response}"
}

########################################
# ssh helpers
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
        KEY_PATH="${HOME}/.ssh/${ACCOUNT}-keypair.pem"
        ssh -l ec2-user -i "${KEY_PATH}" "${IP_ADDRESS}"
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

function first_push() {
  local branch=""
  branch="$(git rev-parse --abbrev-ref HEAD)"

  if  git rev-parse --abbrev-ref '@{u}' > /dev/null 2>&1
  then
    # This branch is tracking a remove branch
    errcho "Already tracking remote branch push normally with \`git push\`"
  else
    # NOT TRACKING remote branch
    git push -u origin "${branch}"
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
function get_current_context_cluster_name() {
  local name=""
  name=$(kubectl config view -o json \
   | jq \
      -r \
      --arg CTX "$(kubectl config current-context)" \
      '.contexts[] | select(.name | contains($CTX)) | .context.cluster'
    )
  local hasSlash="[\/]"
  if [[ $name =~ $hasSlash ]]; then
    echo "$name" | awk '{ split($1, a, "/"); print a[2]; }'
  else
    echo "$name"
  fi
}

function iterm2_print_user_vars() {
    iterm2_set_user_var nodeVersion "$(node --version)"
    iterm2_set_user_var npmVersion "$(npm --version)"
    iterm2_set_user_var kubeContext "$(get_current_context_cluster_name)"
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
  builtin cd "$@" || return
  clear
  gls -alp --color=auto --group-directories-first
  nvmcheck
}

nvmcheck() {
  nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')
  # If there are no .nvmrc file, use the default nvm version
  if [[ ! $nvm_path = *[^[:space:]]* ]]; then

    declare default_version;
    default_version=$(nvm version default);

    # If there is no default version, set it to `node`
    # This will use the latest version on your machine
    if [[ $default_version == "N/A" ]]; then
      nvm alias default node;
      default_version=$(nvm version default);
    fi

    # # If the current version is not the default version, set it to use the default version
    # if [[ $(nvm current) != "$default_version" ]]; then
    #   nvm use default;
    # fi

  elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
    declare nvm_version
    nvm_version=$(<"$nvm_path"/.nvmrc)

    declare locally_resolved_nvm_version
    # `nvm ls` will check all locally-available versions
    # If there are multiple matching versions, take the latest one
    # Remove the `->` and `*` characters and spaces
    # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
    locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

    # If it is not already installed, install it
    # `nvm install` will implicitly use the newly-installed version
    if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
      nvm install "$nvm_version";
    elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
      nvm use "$nvm_version";
    fi
  fi
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
        ${NVM_BIN}/dotfiles "$@"
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
    docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it $container "$@"
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

########################################
# Tmux
########################################
tmux_set_pane_title() {
  printf '\033]2;%s\033\\' "$1"
}

tmux_default_session() {
  echo "${USER}-main"
}

tmux_interactive_get_session() {
  local tmux_session=""
  tmux_session=$(tmux list-sessions \
    | ipt -u \
    | cut -d ':' -f 1)

  echo "${tmux_session}"
}

tmux_list_sessions() {
  local tmux_sessions=""
  tmux_sessions=$(tmux list-sessions -F '#S')

  echo "${tmux_sessions}"
}

tmux_find_session() {
  local tmux_session=$1
  local found=""

  for session in $(tmux_list_sessions)
  do
    if [[ "${session}" == "${tmux_session}" ]]
    then
      found="${session}"
    fi
  done

  echo "${found}"
}

tmux_create_session() {
  if [[ $# -eq 1 ]]
  then
    selected=$1
  else
    selected=$(find ~/repos ~/auth0 -mindepth 1 -maxdepth 1 -type d | fzf)
  fi

  if [[ -z $selected ]]
  then
    return
  fi

  selected_name=$(basename "$selected")

  if [[ -z $TMUX ]]
  then
    tmux new-session -s "$selected_name" -c "$selected"
    return
  fi

  if ! tmux has-session -t "$selected_name" 2> /dev/null
  then
    tmux new-session -ds "$selected_name" -c "$selected"
  fi

  tmux switch-client -t "$selected_name"
}

tmux_attach_session() {
  local tmux_session=""
  tmux_session=$(tmux_interactive_get_session)

  tmux attach -t "${tmux_session}"
}

tmux_delete_session() {
  local tmux_session=""
  tmux_session=$(tmux_interactive_get_session)

  tmux kill-session -t "${tmux_session}"
}


########################################
# Taskwarrior
########################################
task_annotate() {
  trap '[[ -n ${annot_file:-} ]] && rm -f "$annot_file"' EXIT

  local filter="$1"
  shift
  annot="$*"

  # Check if any task exists
  if ! task info "$filter" > /dev/null 2>&1; then
    echo "No tasks found."
  elif [[ -n "$annot" ]]; then
    # Use annotation from CLI if provided
    task $filter annotate "$annot"
  else
    # Use annotation from editor
    # Add file extension to get syntax highlighting
    local annot_file="$(mktemp).md"
    $EDITOR "$annot_file"

    if [[ "$(wc -l "$annot_file" | cut -d ' ' -f 1)" -gt 1 ]]; then
      annot="\n$(cat "$annot_file")"
    else
      annot="$(cat "$annot_file")"
    fi

    # Print annotation if error saving, otherwise the user will lose it
    if ! task $filter annotate "$annot"; then
      echo "Error annotating task. Here is your annotation:"
      echo
      echo "$annot"
    fi
  fi
}
