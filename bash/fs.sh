#!/bin/bash

#
# mkdir -p and cd
# -----------------------------------------------------------

mm(){
  local filename=$1
  if [[ -e "$filename" ]]; then
    echo "$filename exists"
    cd $1
    return 0
  fi

  mkdir -p "$filename"
  cd "$filename"
}
