#!/bin/sh

###########
# include #
###########

source ./zsh/zshenv

############
# function #
############

function install() {
  . $DOTFILES/install/$1.sh
}

function installCmd() {
  command -v $1 >/dev/null && install $1
}

###########
# install #
###########

install zsh
