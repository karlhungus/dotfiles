#!/bin/bash
set -euo pipefail

applied() {
  [[ "$(which php && php version)" =~ "PHP version" ]]
}

apply() {
  if osx; then
    brew tap homebrew/homebrew-php
    brew update
    brew install php56 --with-pear
  elif linux; then
    sudo apt-get install -y apache2 php mysql-server php-mysql
  fi
}
