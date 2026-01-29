#!/bin/bash

#
# Open the target with vscode with a workspace
# -----------------------------------------------------------

# Uncomment the following line to use cursor instead of vscode
# -----------------------------------------------------------

USE_CURSOR=1

# Usage
# - `a` open current directory
# - `a .` open the current directory
# - `a dir` open the directory `dir`
# - `a -n` open the current directory in a new window
# - `a -n dir` open the directory `dir` in a new window
a(){
  local add
  local new_window

  if [[ "$1" = "-a" ]]; then
    add=1
    shift
  fi

  if [[ "$1" = "-n" ]]; then
    new_window=1
    shift
  fi

  local file=${1:-.}

  if [[ -n "$USE_CURSOR" ]]; then
    if [[ $add = "1" ]]; then
      cursor ${new_window:+-n} -a "$file"
    else
      cursor ${new_window:+-n} "$file"
    fi
  else
    if [[ $add = "1" ]]; then
      code ${new_window:+-n} -a "$file"
    else
      code ${new_window:+-n} "$file"
    fi
  fi
}

#
# Add the target to the current vscode workspace
# -----------------------------------------------------------

aa(){
  a -a $@
}
