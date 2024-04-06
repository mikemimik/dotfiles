#!/usr/bin/env bash

[ -r "${HOME}/.bash_exports" ] && [ -f "${HOME}/.bash_exports" ] && source "${HOME}/.bash_exports"
[ -r "${HOME}/.bash_functions" ] && [ -f "${HOME}/.bash_functions" ] && source "${HOME}/.bash_functions"
[ -r "${HOME}/.bash_aliases" ] && [ -f "${HOME}/.bash_aliases" ] && source "${HOME}/.bash_aliases"
[ -r "${HOME}/.bash_completion" ] && [ -f "${HOME}/.bash_completion" ] && source "${HOME}/.bash_completion"

# Check if NVM exists then source it
[ -s "${NVM_INSTALL_DIR}/nvm.sh" ] && source "${NVM_INSTALL_DIR}/nvm.sh"  # This loads nvm
[ -n "${TMUX}" ] && tmux setenv -g "TMUX_NVM_$(tmux display -p "#D" | tr -d %)" "${NVM_BIN}"

# Add bash-git-prompt

## BASH-GIT-PROMPT OPTIONS
# GIT_PROMPT_THEME=Single_line_Dark
GIT_PROMPT_THEME=Custom

if [ -f "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="${HOMEBREW_PREFIX}/opt/bash-git-prompt/share"
    source "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"
fi
