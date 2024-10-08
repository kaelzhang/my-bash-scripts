#!/bin/bash

#
# Npm publish
# -----------------------------------------------------------

np(){
  echo "npm publish $@"
  npm publish $@
}

#
# Git tag, push --tags and npm publish
# -----------------------------------------------------------

gnp(){
  local version=$(node -e "console.log(require('./package.json').version)" 2> /dev/null)
  local private=$(node -e "console.log(require('./package.json').private)" 2> /dev/null)

  if [[ $private = "true" ]]; then
    echo "Project marked as > PRIVATE <, skip npm publishing"

    git tag $version &&
    gp --tags

    return $?
  fi

  np $@ &&
  git tag $version &&
  gp --tags
}

#
# Pick a npm name
# -----------------------------------------------------------

pick(){
  if [[ ! -d "$HOME/.npm-pick" ]]; then
    mkdir "$HOME/.npm-pick"
  fi

  local name=$1

  if [[ ! -n "$name" ]]; then
    echo "please specify a name"
    return
  fi

  shift

  cd "$HOME/.npm-pick"
  echo "{\"name\": \"$name\", \"version\": \"0.0.0\", \"description\": \"\", \"main\": \"index.js\", \"scripts\": {}, \"license\": \"MIT\"}" > package.json

  npm publish $@
  cd -
}

#
# Remove all node_modules directory recursively
# -----------------------------------------------------------

rm-node-modules(){
  find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}
