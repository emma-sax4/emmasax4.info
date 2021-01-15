#!/bin/bash

deploy_status=$1

if [[ $deploy_status == "skipped" ]]; then
  echo "DEPLOY_MESSAGE= Deploy was *skipped*." >> $GITHUB_ENV
elif [[ $deploy_status == "success" ]]; then
  echo "DEPLOY_MESSAGE= Deploy was *successful*." >> $GITHUB_ENV
elif [[ $deploy_status == "failed" ]]; then
  echo "DEPLOY_MESSAGE= Deploy was *unsuccessful*." >> $GITHUB_ENV
fi
