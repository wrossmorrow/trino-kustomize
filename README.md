
# Introduction

This repo contains [`kustomize`](https://kustomize.io/) templates for deploying [`trino`](https://trino.io/) into `kubernetes`. `trino` publishes a `helm` chart ([here](https://github.com/trinodb/charts)). `kustomize` is a `k8s`-native alternative to `helm` that follows a very different strategy: layering and merging instead of templating. In some ways it is easier to work with, in some ways it's harder. For example, compare the messy specific replacements in `kustomize/359` -- which are easy in `helm` -- to the relatively compact, declarative and flexible actual deployment spec in `example/`. In general `kustomize` templates are _much_ easier to read for someone loosely familiar with `kubernetes` manifests. `helm` charts just get very cluttered with templating directives. 

# Quick Start

Once you have `kustomize` you can build full manifests for a deployment with, say, 
```
$ kustomize build kustomize/359
```
This will print out all the component specs to `stdout`. I like the flow 
```
$ kustomize build kustomize/359 > trino.yaml && kubectl apply -f trino.yaml
```
to have a local reviewable record of what's deployed. You can feed `stdout` into `kubectl` or try 
```
$ kubectl -k kustomize/359
```
but I've found this to significantly lag behind in useful features. 

# Example

The base templates in `kustomize/latest` and `kustomize/359` aren't really meant to be used on their own. See `example/` for a simple "real" deployment spec that layers on top of `kustomize/359`. In this example we
* _add_ a couple catalogs with new `data` fields for the `trino-catalog` `ConfigMap`
* specify `nodeSelector`s for the `coordinator` and `workers` (for GKE node pools)
* add an `annotation` to the `trino` `Service` (pointing at the `coordinator`) to give it an internal load balancer address (in GKE)