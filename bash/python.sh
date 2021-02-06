#!/bin/bash

#
# Git tag, git push --tags, and publish to PyPI
# -----------------------------------------------------------

gpp(){
  version=$(echo "from setup import __version__\nprint(__version__)" | python)

  if [[ ! -n "$version" ]]; then
    echo "fails to get version"
    return 1
  fi

    echo "version: $version\n"

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
