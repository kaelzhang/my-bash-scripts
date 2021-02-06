#!/bin/bash

#
# Enhanced `git pull --rebase`
# -----------------------------------------------------------

gl(){
  local current_branch=`_git_get_current_branch`
  echo "git pull --rebase origin $current_branch"
  git pull --rebase origin $current_branch
}

#
# Enhanced `git push`
# -----------------------------------------------------------

gp(){
  local current_branch=`_git_get_current_branch`

  if [[ $1 = "-f" ]]; then
    echo "git push origin $current_branch -f"
    git push origin $current_branch -f
    return $?
  fi

  echo "git pull --rebase origin $current_branch"
  git pull --rebase origin $current_branch
  if [[ $? -ne 0 ]] ; then
     return $?
  else
    echo
    echo "git push $@ origin $current_branch"
    git push origin $@ $current_branch
  fi
}

#
# Just submit a WIP commit and publish
# -----------------------------------------------------------

gap(){
  git commit -a -m 'WIP'
  gp
}


_git_get_current_branch(){
  # old version of git does not support --short
  git symbolic-ref --short HEAD
  # result=`git symbolic-ref HEAD`
  # array=(${result//// })
  # echo ${array[2]}
}
