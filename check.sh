BASEDIR=$( git rev-parse --show-toplevel )
for K in ${BASEDIR}/*/kustomization.yaml ; do 
    kustomize build $( dirname $K ) 1> /dev/null
done