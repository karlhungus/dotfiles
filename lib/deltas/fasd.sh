#!/bin/bash
set -euo pipefail

define_option short=v long=version variable=version desc="The version to install"

valid_options() {
  # not a failure, brew takes care of osx
  if osx; then return 0; fi
  [ -n "${version+x}" ]
}

applied() {
  [[ "$(which fasd && fasd --version)" =~ "${version}" ]]
}

apply() {
  download_file "https://github.com/clvv/fasd/archive/${version}.tar.gz" /tmp || return $?
  extract_archive "/tmp/${version}.tar.gz" || return $?

  pushd /tmp/fasd-${version} >/dev/null
  sudo make install 
  popd >/dev/null

  sudo rm -rf /tmp/v${version}.tar.gz /tmp/fasd-${version}
}
