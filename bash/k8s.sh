#!/usr/bin/env bash

# alias kgaa='kubectl get all --all-namespaces'
kgaa(){
  echo "kubectl get all --all-namespaces $@"
  kubectl get all --all-namespaces $@
}

# Remove all dangling docker images
drmi(){
  docker rmi $(docker images -f "dangling=true" -q)
}
