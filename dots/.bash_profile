[ -r ~/.bash_exports ] && [ -f ~/.bash_exports ] && source ~/.bash_exports
[ -r ~/.bash_functions ] && [ -f ~/.bash_functions ] && source ~/.bash_functions
[ -r ~/.bash_aliases ] && [ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -r ~/.bash_completion ] && [ -f ~/.bash_completion ] && source ~/.bash_completion

# Check if NVM exists then source it
[ -s "$NVM_INSTALL_DIR/nvm.sh" ] && source "$NVM_INSTALL_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_INSTALL_DIR/etc/bash_completion.d/nvm" ] && source "$NVM_INSTALL_DIR/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
[ -n "$TMUX" ] && tmux setenv -g "TMUX_NVM_$(tmux display -p "#D" | tr -d %)" "$NVM_BIN"

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

# Load iterm2 integration script
# test -e "${HOME}/.iterm2_shell_integration.sh" && source "${HOME}/.iterm2_shell_integration.sh"
