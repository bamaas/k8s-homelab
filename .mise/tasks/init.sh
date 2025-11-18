#!/usr/bin/env bash
#MISE description="Initialize the repo"
set -e

echo "Initializing repository..."

# Set githooks
echo "Setting githooks"
git config --local core.hooksPath .githooks/

printf "\e[32mRepository initialized.\e[0m\n"