#!/bin/bash

if [[ ${{ env.DEPLOYMENT_STATUS }} == skipped ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *skipped*)"
elif [[ ${{ env.DEPLOYMENT_STATUS }} == success ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *successful*)"
elif [[ ${{ env.DEPLOYMENT_STATUS }} == failed ]]; then
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *unsuccessful*)"
fi
