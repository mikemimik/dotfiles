#!/bin/bash

#### README ###################################################################
#
# This file will iterate over all the folders in the `apps/` directory. It will
# execute the `install.sh` file in that folder (if it exists).
#
###############################################################################

apps=$(ls ${DOTFILES_DIR}/apps)

for app in ${apps}; do
  install_file=${DOTFILES_DIR}/apps/${app}/install.sh
  [ -f ${install_file} ] && . ${install_file}
done
