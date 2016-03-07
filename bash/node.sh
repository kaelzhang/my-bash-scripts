#!/bin/bash

echo "load my node scripts"

np(){
  npm publish
}

gnp(){
  version=$(node -e "var version = require('package.json').version; console.log(version)")
  np &&
  git tag $version &&
  gp --follow-tags
}
