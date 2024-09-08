#!/bin/bash

#
# Git tag, git push --tags, and publish to PyPI
# -----------------------------------------------------------

gpp(){
  local version
  local private

  if [[ -f "setup.py" ]]; then
    version=$(echo "from setup import __version__\nprint(__version__)" | python)
    private=$(echo "import setup\nprint('private' in dir(setup))" | python)
  fi

  # Check if project is marked as private
  if [[ $private = "True" ]]; then
    echo "Project marked as > PRIVATE <, skip publishing to PyPI"

    git tag $version &&
    gp --tags

    return $?
  fi

  if make publish; then
    echo "publish successfully"
  else
    echo "publish failed"
    return 1
  fi

  # Fallback to get from `/dist` folder
  if [[ ! -n "$version" ]]; then
    if [[ -d "dist" ]]; then
      version=$(find dist -maxdepth 1 -type f -name '*-[0-9]*.[0-9]*.[0-9]*.tar.gz' | head -n 1 | sed -E 's/.*-([0-9]+\.[0-9]+\.[0-9]+)\.tar\.gz/\1/')
    fi
  fi

  if [[ ! -n "$version" ]]; then
    echo "fails to get version"
    return 1
  fi

  echo "version: $version\n"

  git tag $version &&
  gp --tags
}
