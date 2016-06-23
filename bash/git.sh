#!/bin/bash

echo "load my git scripts"

# Enhanced `git pull --rebase`
#
gl(){
  local current_branch=`_git_get_current_branch`
  echo "git pull --rebase origin $current_branch"
  git pull --rebase origin $current_branch
}

# Enhanced `git push`
#
# gp(){
#   local current_branch=`_git_get_current_branch`
#   echo "git push $@ origin $current_branch"
#   git push $@ origin $current_branch
# }

gp(){
  local current_branch=`_git_get_current_branch`
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

gap(){
  git commit -a -m 'a'
  gp
}

rl(){
  local version="$1"
  git hf update && git hf release start "$version" && git hf release finish "$version"
}

_git_get_current_branch(){
  # old version of git does not support --short
  git symbolic-ref --short HEAD
  # result=`git symbolic-ref HEAD`
  # array=(${result//// })
  # echo ${array[2]}
}