#!/bin/bash
set -euo pipefail

define_option short=v long=version variable=version desc="The version to install"

valid_options() {
  [ -n "${version+x}" ]
}

applied() {
  [[ "$(which go && go version)" =~ "go version go${version}" ]]
}

apply() {
  local os_type=$(uname | tr '[:upper:]' '[:lower:]')
  local package_name="go${version}.${os_type}-amd64.tar.gz"

  download_file "https://storage.googleapis.com/golang/${package_name}" /tmp || return $?
  extract_archive "/tmp/${package_name}" "/usr/local" "sudo"|| return $?
  if linux; then
    sudo ln -sf /usr/local/go/bin/go /usr/bin/go
    sudo ln -sf /usr/local/go/bin/gofmt /usr/bin/gofmt
  elif osx; then
    sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go
    sudo ln -sf /usr/local/go/bin/gofmt /usr/local/bin/gofmt
  fi
  sudo rm "/tmp/${package_name}"
}
