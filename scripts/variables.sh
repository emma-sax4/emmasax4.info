#!/bin/bash

workflow=$1
github_repo=$2
ref=$3
run_id=$4

if [ $workflow = "develop" ]; then
  head_ref=$5
  echo "Develop"
  pull_id=$(echo $ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
  echo "::set-env name=PULL_ID::$pull_id"
  echo "::set-env name=PULL_URL::$(echo https://github.com/$github_repo/pull/$pull_id)"
  echo "::set-env name=BRANCH::$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')"
elif [ $workflow = "release" ]; then
  github_actor=$5
  echo "Release workflow"

  if [[ $github_actor = 'pr-scheduler[bot]' ]]; then
    echo "pr Scheduler"
    echo "::set-env name=ACTOR_ICON::https://i.imgur.com/tmdeggv.png"
  else
    echo "not PR scheduler"
    echo "::set-env name=ACTOR_ICON::https://github.com/$github_actor.png"
  fi
fi

if [ $workflow = "release" ] || [ $workflow = "cron" ]; then
  echo "Release workflow or Cron workflow!"
  echo "::set-env name=BRANCH::$(echo $ref | sed -E 's|refs/[a-zA-Z]+/||')"
fi

echo "::set-env name=BUILD_URL::$(echo https://github.com/$github_repo/actions/runs/$run_id)"
