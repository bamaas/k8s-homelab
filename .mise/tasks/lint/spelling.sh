#!/usr/bin/env bash
#MISE description="Check spelling with codespell"
set -e

echo "Checking spelling..."
codespell --config ".lint/codespell.ini" . 