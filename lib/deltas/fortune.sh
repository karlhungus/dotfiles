#!/bin/bash
set -euo pipefail

define_option short=v long=version variable=version desc="The version to install"

valid_options() {
  [ -n "${version+x}" ]
}

applied() {
  [[ "$(which fortune)" =~ "fortune-mod" ]]
}

apply() {
  if linux; then
    pushd "files/lib/fortune/fortune-mod-smac-0.1" || return $? >/dev/null
  else
    pushd "files/lib/fortune/fortune-mod-smac-0.1-osx" || return $? >/dev/null
  fi
  ./make install
  popd >/dev/null
}
