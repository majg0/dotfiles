#!/bin/bash

source common.sh

runmods alias

test -f ~/.aliases && source ~/.aliases
