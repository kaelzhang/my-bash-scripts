#!/bin/bash

__my_bash_scripts=(git node vscode conda)

for sub in $__my_bash_scripts
do
  echo "load my $sub scripts"
  source "$MY_BASH_SCRIPTS_DIR/bash/$sub.sh"
done

unset __my_bash_scripts
