#!/bin/bash
set -euo pipefail

define_option short=r long=repo variable=repo desc="The repository (owner/repo) to clone"
define_option short=s long=sha variable=sha desc="The SHA to check out"
define_option short=c long=cmd variable=cmd default="" desc="An optional command to run after cloning"
define_option short=t long=target_root variable=target_root default="/usr/local/src/" desc="An optional target root"

valid_options() {
  if [ -z "${repo+x}" ] || [ -z "${sha+x}" ]; then return 1; fi

  target_dir=$target_root
  if [ ${target_root} == "/usr/local/src/" ]; then
    target_dir="${target_root}${repo##*/}"
  fi
  cmd="${cmd:-}"
}

applied() {
  if [ ! -d "${target_dir}" ]; then return 1; fi

  pushd "${target_dir}" >/dev/null
  local head_sha=$(git rev-parse --short HEAD)
  popd >/dev/null

  [ "${head_sha}" == "${sha}" ]
}

apply() {
  local prefix=""

  if [[ -d ${target_root} && ! -w $target_root ]]; then prefix="sudo "; fi
  if [ ! -d "${target_dir}" ]; then
    $prefix mkdir -p "${target_dir}"
    $prefix git clone "https://github.com/${repo}" "${target_dir}"
  fi

  pushd "${target_dir}" >/dev/null
  $prefix git fetch --all -p
  $prefix git checkout "${sha}"
  if [ -n "${cmd}" ]; then eval "${cmd}"; fi
  popd >/dev/null
}
