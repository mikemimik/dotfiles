#!/bin/bash

EXT_LIST=$(code --list-extensions)

extensions=(
  chenxsan.vscode-standardjs
  Dart-Code.dart-code
  Dart-Code.flutter
  dbaeumer.vscode-eslint
  dkundel.vscode-new-file
  eamodio.gitlens
  Equinusocio.vsc-material-theme
  flowtype.flow-for-vscode
  mauve.terraform
  mohsen1.prettify-json
  ms-python.python
  ms-vscode.Go
  ms-vscode.Theme-TomorrowKit
  PeterJausovec.vscode-docker
  Pivotal.vscode-concourse
  PKief.material-icon-theme
  wholroyd.HCL
)

for extension in ${extensions[@]}; do
  is_installed="false"
  for installed_ext in ${EXT_LIST[@]}; do
    if [ ${extension} == ${installed_ext} ]; then
      echo "${extension} already installed"
      is_installed="true"
      break
    fi
  done

  if [ "${is_installed}" == "false" ]; then
    code --install-extension ${extension}
  fi
done
