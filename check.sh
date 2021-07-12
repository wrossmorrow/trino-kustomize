#!/bin/bash
for K in */kustomization.yaml ; do 
    kustomize build $( dirname $K ) 1> /dev/null
done