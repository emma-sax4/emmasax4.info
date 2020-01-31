#!/bin/bash
set -e
# This script is called by Travis during the install step.
# It returns false if one or zero files where changed. Otherwise,
# it returns true.

CHANGED_FILES=$(git diff --name-only)
if [[ $CHANGED_FILES == *$'\n'* ]]; then
  echo "Travis identified multiple files changed from this build:"
  echo $CHANGED_FILES
  exit 0 # true
else
  echo "Travis identified zero or one file(s) changed from this build:"
  echo $CHANGED_FILES
  exit 1 # false
fi
