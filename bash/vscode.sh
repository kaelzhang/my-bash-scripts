#!/bin/bash

#
# Open the target with vscode
# -----------------------------------------------------------
#
# Usage
# - `v` open current directory
# - `v .` open the current directory
# - `v dir` open the directory `dir`
# - `v -n` open the current directory in a new window
# - `v -n dir` open the directory `dir` in a new window
# - `v -a dir` add the directory `dir` to the current workspace
v(){
  local add
  local new_window
  local cursor

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -a)
        add=1
        shift
        ;;
      -n)
        new_window=1
        shift
        ;;
      --cursor)
        cursor=1
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  local file=${1:-.}

  if [[ $cursor = "1" ]]; then
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

c(){
  v --cursor $@
}

#
# Add the target to the current vscode workspace
# -----------------------------------------------------------

vv(){
  v -a $@
}

#
# Add the target to the current cursor workspace
# -----------------------------------------------------------

cc(){
  v --cursor -a $@
}
