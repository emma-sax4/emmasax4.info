#!/bin/bash

workflow=$1

if [ $workflow = "develop" ]; then
  echo "Develop"
  pull_id=$(echo ${{ github.ref }} | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
  echo "::set-env name=PULL_ID::$pull_id"
  echo "::set-env name=PULL_URL::$(echo https://github.com/${{ github.repository }}/pull/$pull_id)"
  echo "::set-env name=BRANCH::$(echo ${{ github.head_ref }} | sed -E 's|refs/[a-zA-Z]+/||')"
elif [ $workflow = "release" ]; then
  echo "Release workflow"
  if [[ ${{ github.actor }} = 'pr-scheduler[bot]' ]]; then
    echo "pr Scheduler"
    echo "::set-env name=ACTOR_ICON::https://i.imgur.com/tmdeggv.png"
  else
    echo "not PR scheduler"
    echo "::set-env name=ACTOR_ICON::https://github.com/${{ github.actor }}.png"
  fi
fi

if [ $workflow = "release" ] || [ $workflow = "cron" ]; then
  echo "Release workflow or Cron workflow!"
  echo "::set-env name=BRANCH::$(echo ${{ github.ref }} | sed -E 's|refs/[a-zA-Z]+/||')"

fi

echo "::set-env name=BUILD_URL::$(echo https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})"
