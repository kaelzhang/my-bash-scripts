#!/bin/bash

#
# Open the target with vscode with a workspace
# -----------------------------------------------------------

# Uncomment the following line to use cursor instead of vscode
# -----------------------------------------------------------

USE_CURSOR=1

a(){
  local add

  if [[ "$1" = "-a" ]]; then
    add=1
    shift
  fi

  local file=${1:-.}

  if [[ -n "$USE_CURSOR" ]]; then
    if [[ $add = "1" ]]; then
      cursor -a "$file"
    else
      cursor "$file"
    fi
  else
    if [[ $add = "1" ]]; then
      code -a "$file"
    else
      code "$file"
    fi
  fi
}

#
# Add the target to the current vscode workspace
# -----------------------------------------------------------

aa(){
  a -a $@
}
