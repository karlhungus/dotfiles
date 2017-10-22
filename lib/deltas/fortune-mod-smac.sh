#!/bin/bash
set -euo pipefail

applied() {
  PATH=$PATH:/usr/games
  [[ "$(which fortune && fortune smac -version)" =~ "fortune-mod version" ]]
}

apply() {
  if linux; then
    pushd "lib/fortune/fortune-mod-smac-0.1" || return $? >/dev/null
  else
    pushd "lib/fortune/fortune-mod-smac-0.1-osx" || return $? >/dev/null
  fi
  sudo make install
  popd >/dev/null
}
