#!/bin/bash

#
# Git tag, push

gpp(){
  version=$(echo "from setup import __version__\nprint(__version__)" | python)
  private=$(echo "import setup\nprint('private' in dir(setup))" | python)

  if [[ $private = "True" ]]; then
    echo "Project marked as > PRIVATE <, skip publishing to PyPI"

    git tag $version &&
    gp --tags

    return $?
  fi

  make publish &&
  git tag $version &&
  gp --tags
}
