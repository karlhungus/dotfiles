#!/bin/bash
set -euo pipefail

applied() {
  [[ "$(which php && php version)" =~ "PHP version" ]]
}

apply() {
  if osx; then
    brew tap homebrew/homebrew-php
    brew update
    brew install php70 --with-pear
    sudo pear channel-discover pear.symfony-project.com
  elif linux; then
    sudo apt-get install -y apache2 php mysql-server php-mysql php-pear
    sudo pear channel-discover pear.symfony-project.com
  fi
}
