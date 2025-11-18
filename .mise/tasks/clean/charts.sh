#!/usr/bin/env bash
#MISE description="Clean the charts"
set -e

echo "Cleaning the charts..."
find . -type d -name charts | while read -r dir; do
    echo "Removing directory: $dir"
    rm -rf "$dir"
done
