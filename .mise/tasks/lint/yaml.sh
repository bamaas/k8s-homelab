#!/usr/bin/env bash
#MISE description="Lint yaml files"
set -e

echo "Linting YAML files..."
yamllint . -c ".lint/yamllint.yaml"