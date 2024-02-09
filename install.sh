#!/bin/bash

set -e

MOD=${1:-ubuntu}

source ./common.sh

source ./env.sh

runmods $MOD installing installed
