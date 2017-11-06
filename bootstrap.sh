#!/bin/bash

source_tar="https://github.com/karlhungus/dotfiles/archive/master.tar.gz"
temp_dir="$(mktemp -u)"
clone_dir="${HOME}/dotfiles"

main() {
  mkdir -p "${temp_dir}"
  mkdir -p "${clone_dir}"

  curl -L "${source_tar}" > "${temp_dir}/master.tar.gz"
  tar xzf "${temp_dir}/master.tar.gz" -C "${clone_dir}" --strip-components=1
  rm -rf "${temp_dir}"

  cd "${clone_dir}"
  bin/setup -a
}

main "$@"
