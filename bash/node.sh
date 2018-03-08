#!/bin/bash

echo "load my node scripts"

np(){
  npm publish
}

gnp(){
  version=$(node -e "console.log(require('./package.json').version)" 2> /dev/null)
  private=$(node -e "console.log(require('./package.json').private)" 2> /dev/null)

  if [[ $private = "true" ]]; then
    echo "Project marked as > PRIVATE <, skip npm publishing"

    git tag $version &&
    gp --tags

    return $?
  fi

  np &&
  git tag $version &&
  gp --tags
}
