#!/usr/bin/env bash

# INFO: source all appropriate shell files
bash_files="exports functions aliases completion"

for bash_file in $bash_files
do
  # Create filenames
  file=".bash_${bash_file}"
  file_work=${file}_work

  # Create file paths
  file_path="${HOME}/${file}"
  file_work_path="${HOME}/${file_work}"

  # Source files; if they exist
  [ -r "${file_path}" ] && [ -f "${file_path}" ] && source "${file_path}"
  [ -r "${file_work_path}" ] && [ -f "${file_work_path}" ] && source "${file_work_path}"
done

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
