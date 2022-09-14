#!/bin/sh

set -e

###########
# include #
###########

source ./zsh/zshenv

############
# function #
############

function install() {
  echo "installing $1..."
  . $DOTFILES/install/$1.sh
  echo "installed $1"
}

function installIf() {
  if [ $? -eq 0 ]; then
    echo "$1 already installed"
  else
    install $1
  fi
}

function installCmd() {
  command -v $1 > /dev/null
  installIf $1
}

function installChecked() {
  . $DOTFILES/install/$1-check.sh
  installIf $1
}

###########
# install #
###########

install zsh
installCmd brew
installChecked font
installCmd op
installCmd kitty
install starship

# TODO: cleanup
brew install bat ripgrep fnm starship rust-analyzer
