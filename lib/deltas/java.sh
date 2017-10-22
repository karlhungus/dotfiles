#!/bin/bash
set -euo pipefail

applied() {
  [[ $(which java && java -version) =~ "java" ]]
}

apply() {
  if osx; then
    brew cask install java
  elif linux; then
    sudo apt-get install -y default-jre
  fi
}
