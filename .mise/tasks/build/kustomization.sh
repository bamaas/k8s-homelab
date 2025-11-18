#!/usr/bin/env bash

set -eo pipefail

# Script arguments
kustomize_dir_path="$1"
validate_schema="${2:-false}"

# Validate path is provided
if [ -z "${kustomize_dir_path}" ]; then
    echo "Error: kustomize_dir_path is required"
    exit 1
fi

set -u

# Validate path exists
if [ ! -d "${kustomize_dir_path}" ]; then
    echo "Error: provided path '${kustomize_dir_path}' does not exist."
    exit 1
fi

# Validate kustomization.yaml file is present
if [ ! -f "${kustomize_dir_path}/kustomization.yaml" ]; then
    echo "Error: kustomization.yaml not found in '${kustomize_dir_path}'."
    exit 1
fi

echo "Building manifests for ${kustomize_dir_path}" 1>&2

# Creating the command
cmd="kustomize build --enable-helm --enable-alpha-plugins --enable-exec --load-restrictor=LoadRestrictionsNone ${kustomize_dir_path}"
if [ "$validate_schema" = "true" ]; then
    cmd="${cmd} | kubeconform -ignore-missing-schemas -summary -strict -kubernetes-version 1.32.0"
fi

# Run the command
eval "${cmd}"