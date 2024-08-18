#!/usr/bin/env bash

# alias kgaa='kubectl get all --all-namespaces'
kgaa(){
  echo "kubectl get all --all-namespaces $@"
  kubectl get all --all-namespaces $@
}
