#!/bin/sh

## add
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'

## checkout
alias gcob='git checkout -b'
alias gcom='git checkout master'

## clean
alias gnfd='git clean -fd'

## commit
alias gc='git commit'
alias gca='git commit --amend'
alias gcf='git commit --fixup'
alias gcm='git commit --message'
alias gcn='git commit --no-verify'
alias gcna='git commit --no-verify --amend'
alias gcnf='git commit --no-verify --fixup'
alias gcnm='git commit --no-verify --message'

## diff
alias gd='git diff'
alias gdc='git diff --cached'

## log
alias gl='git log'

## merge
alias gmod='git merge origin/develop'

## pull
alias gp='git pull'
alias gpo='git pull origin'
alias gpod='git pull origin develop'
alias gpa='git pull --autostash'
alias gpao='git pull --autostash origin'
alias gpaod='git pull --autostash origin develop'
alias gpr='git pull --rebase'
alias gpro='git pull --rebase origin'
alias gprod='git pull --rebase origin develop'
alias gpra='git pull --rebase --autostash'
alias gpraod='git pull --rebase --autostash origin develop'

## push
alias gu='git push'
alias guf='git push --force-with-lease'

## rebase
alias griaa='git rebase -i --autosquash --autostash'
alias grc='git rebase --continue'

## reset
alias gt='git reset'
alias gth='git reset --hard'
alias gthod='git reset --hard origin/develop'

## show
alias gw='git show'

## stash
alias gx='git stash'
alias gxd='git stash drop'
alias gxl='git stash list'
alias gxp='git stash pop'
alias gxs='git stash show'

## status
alias gs='git status'

