#!/bin/bash
set -euo pipefail

applied() {
  local TEST=$(/usr/games/fortune smac -m PYRRHO) > /dev/null
  [[ $TEST =~ "TERMINATION" ]]
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
