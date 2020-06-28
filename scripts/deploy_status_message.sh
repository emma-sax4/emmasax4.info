#!/bin/bash

deploy_status=$1

if [[ $deploy_status == skipped ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *skipped*)"
elif [[ $deploy_status == success ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *successful*)"
elif [[ $deploy_status == failed ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *unsuccessful*)"
fi
