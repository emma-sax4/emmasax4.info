#!/bin/bash

deploy_status=$1

if [[ $deploy_status == skipped ]]; then
  echo "Deploy to GitHub Pages was *skipped*." > deploy-status-message.txt
elif [[ $deploy_status == success ]]; then
  echo "Deploy to GitHub Pages was *successful*." > deploy-status-message.txt
elif [[ $deploy_status == failed ]]; then
  echo "Deploy to GitHub Pages was *unsuccessful*." > deploy-status-message.txt
fi
