#!/bin/bash
set -euo pipefail

define_option short=v long=version variable=version desc="The version to install"

valid_options() {
  [ -n "${version}" ]
}

applied() {
  # done through brew on osx
  if osx; then return 0; fi
  [[ "$(which rg && rg --version)" =~ "ripgrep ${version}" ]]
}

apply() {
  local archive_name="ripgrep-${version}-x86_64-unknown-linux-musl"
  download_file "https://github.com/BurntSushi/ripgrep/releases/download/${version}/${archive_name}.tar.gz" /tmp || return $?
  extract_archive "/tmp/${archive_name}.tar.gz" || return $?

  pushd /tmp/${archive_name} >/dev/null
  sudo cp /tmp/${archive_name}/rg /usr/local/bin/
  popd >/dev/null

  rm -rf "/tmp/${archive_name}.tar.gz" "/tmp/${archive_name}"
}
