[ -r ~/.bash_exports ] && [ -f ~/.bash_exports ] && source ~/.bash_exports
[ -r ~/.bash_functions ] && [ -f ~/.bash_functions ] && source ~/.bash_functions
[ -r ~/.bash_aliases ] && [ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Check if NVM exists then source it
if [ -f "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    source "$NVM_DIR/bash_completion"
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [ -e "$HOME/.ssh/config" ]; then
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
fi

# Add bash-git-prompt

## BASH-GIT-PROMPT OPTIONS
# GIT_PROMPT_THEME=Single_line_Dark
GIT_PROMPT_THEME=Custom

if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

# # SSH keys
# eval $(ssh-agent -s)
# CURRENT_KEYS=$(ssh-add -l | cut -d ' ' -f 3 | cut -d '/' -f 5)

# [ ${CURRENT_KEYS} =~ (^| )$x($| ) ] &&
# ssh-add -K ~/.ssh/id_rsa
# ssh-add -K ~/.ssh/github_rsa
