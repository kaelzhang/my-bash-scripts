#!/bin/bash

source "$MY_BASH_SCRIPTS_DIR/bash/git.sh"

sl(){
  target=${1-.}
  /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$target"
}



# openssl rsa -in ~/.ssh/id_rsa -out ~/.ssh/id_rsa_new