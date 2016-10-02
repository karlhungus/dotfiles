#!/bin/bash
set -euo pipefail

define_option short=r long=repo variable=repo desc="The repository (owner/repo) to clone"
define_option short=s long=sha variable=sha desc="The SHA to check out"
define_option short=R long=grecursive variable=grecursive desc="Clone recursive" default="true" value="true"
define_option short=c long=cmd variable=cmd default="" desc="An optional command to run after cloning"

valid_options() {
  if [ -z "${repo+x}" ] || [ -z "${sha+x}" ]; then return 1; fi

  target_dir="/usr/local/src/${repo##*/}"
  cmd="${cmd:-}"
  grecursive="${grecursive}"
}

applied() {
  if [ ! -d "${target_dir}" ]; then return 1; fi

  pushd "${target_dir}" >/dev/null
  local head_sha=$(git rev-parse --short HEAD)
  popd >/dev/null

  [ "${head_sha}" == "${sha}" ]
}

apply() {
  if [ ! -d "${target_dir}" ]; then
    mkdir -p "${target_dir}"
    if [ $grecursive == "true" ]
    then
      echo "recursive ${repo} ${target_dir}"
      git clone --recursive "https://github.com/${repo}" "${target_dir}"
    else
      echo "nonrecursive ${repo} ${target_dir}"
      git clone "https://github.com/${repo}" "${target_dir}"
    fi
  fi

  pushd "${target_dir}" >/dev/null
  git fetch --all -p
  git checkout "${sha}"
  if [ -n "${cmd}" ]; then eval "${cmd}"; fi
  popd >/dev/null
}
