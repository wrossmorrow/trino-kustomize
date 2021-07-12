BASEDIR=$( git rev-parse --show-toplevel )
for K in ${BASEDIR}/kustomize/*/kustomization.yaml ; do 
    kustomize build $( dirname $K ) 1> /dev/null
done