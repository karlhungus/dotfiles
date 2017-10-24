#!/bin/bash
set -euo pipefail

applied() {
  # you need java to install java... fuuuuu oracle
  if osx; then return 0; fi
  [[ $(which java && java -version) =~ "java" ]]
}

apply() {
  if osx; then
    brew cask install java
  elif linux; then
    sudo apt-get install -y default-jre
  fi
}
