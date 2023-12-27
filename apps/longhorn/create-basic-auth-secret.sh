#!/bin/bash
# how to create basic auth:
# https://github.com/longhorn/longhorn/blob/v0.8.0/docs/longhorn-ingress.md
user=$1; password=$2; output=$3
echo "${user}:$(openssl passwd -stdin -apr1 <<< ${password})" >> auth
kubectl create secret generic basic-auth --dry-run=client -o yaml --from-file=auth > ${output}
rm auth