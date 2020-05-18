#!/bin/bash

#
# Enhanced `git pull --rebase`
#

gl(){
  local current_branch=`_git_get_current_branch`
  echo "git pull --rebase origin $current_branch"
  git pull --rebase origin $current_branch
}

#
# Enhanced `git push`

# gp(){
#   local current_branch=`_git_get_current_branch`
#   echo "git push $@ origin $current_branch"
#   git push $@ origin $current_branch
# }

gp(){
  local current_branch=`_git_get_current_branch`

  if [[ $1 = "-f" ]]; then
    echo "git pull origin $current_branch -f"
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

# gpp(){
#   local current_branch=`_git_get_current_branch`
#   echo "git push $@ origin $current_branch"
#   git push origin $@ $current_branch
# }

gap(){
  git commit -a -m 'a'
  gp
}

# rl(){
#   local version="$1"
#   git hf update && git hf release start "$version" && git hf release finish "$version"
# }

_git_get_current_branch(){
  # old version of git does not support --short
  git symbolic-ref --short HEAD
  # result=`git symbolic-ref HEAD`
  # array=(${result//// })
  # echo ${array[2]}
}
