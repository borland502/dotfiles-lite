#!/usr/bin/env bash

# Exit on any error
set -e

# Check if an argument was provided
if [ -z "$1" ]; then
  echo "false"
  exit 0
fi

# Test if the command exists
if command -v "$1" >/dev/null 2>&1; then
  echo "true"
else
  echo "false"
fi