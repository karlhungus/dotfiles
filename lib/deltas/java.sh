#!/bin/bash
set -euo pipefail

applied() {
  # not a failure, but nothing to do for linux
  if linux; then return 0; fi

  [[ -d /Applications/iTerm.app ]]
}

apply() {
  brew cask install java
}
