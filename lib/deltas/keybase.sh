#!/bin/bash
set -euo pipefail

applied() {
  [[ "$(which keybase && keybase --version)" =~ "keybase" ]]
}

apply() {
  if osx; then
    brew cask install keybase
  elif linux; then
    download_file https://prerelease.keybase.io/keybase_amd64.deb /tmp
    # if you see an error about missing `libappindicator1`
    # # from the next command, you can ignore it, as the
    # # subsequent command corrects it
    sudo dpkg -i /tmp/keybase_amd64.deb
    sudo apt-get install -f
    run_keybase
    rm -rf /tmp/keybase_amd64.deb
  fi
}
