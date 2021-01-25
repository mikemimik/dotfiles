# This is a theme for gitprompt.sh,
# it uses the default openSUSE bash prompt style with exit status

override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_BRANCH="${Cyan}"
  GIT_PROMPT_MASTER_BRANCH="${GIT_PROMPT_BRANCH}"
  GIT_PROMPT_UNTRACKED=" ${Cyan}…${ResetColor}"
  GIT_PROMPT_CHANGED="${Yellow}✚ "
  GIT_PROMPT_STAGED="${Magenta}●"

  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${Green}\u${Green}@${Green}\h:${BoldBlue}\W${ResetColor}"
  GIT_PROMPT_START_ROOT="_LAST_COMMAND_INDICATOR_ ${BoldRed}\u@\h:${BoldBlue}\W${ResetColor}"

  GIT_PROMPT_END_USER="${ResetColor}\n> "
  GIT_PROMPT_END_ROOT=" # ${ResetColor}"
}

reload_git_prompt_colors "Custom"
