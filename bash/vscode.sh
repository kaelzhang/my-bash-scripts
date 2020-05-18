#!/bin/bash

#
# Open the target with vscode with a workspace
#

a(){
  local add

  if [[ "$1" = "-a" ]]; then
    add=1
    shift
  fi

  local file=${1:-.}

  if [[ $add = "1" ]]; then
    code -a "$file"
  else
    code "$file"
  fi
}

#
# Add the target to the current vscode workspace
#

aa(){
  a -a $@
}
