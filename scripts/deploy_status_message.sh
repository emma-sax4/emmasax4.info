#!/bin/bash

status=$1

if [[ $status == skipped ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *skipped*)"
elif [[ $status == success ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *successful*)"
elif [[ $status == failed ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *unsuccessful*)"
fi
