#!/bin/bash

actions_workflow=$1
github_repo=$2
github_ref=$3
actions_run_id=$4

if [[ $actions_workflow == develop ]]; then
  head_ref=$5
  pull_id=$(echo $github_ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')

  echo "::set-env name=PULL_ID::$pull_id"
  echo "::set-env name=PULL_URL::$(echo https://github.com/$github_repo/pull/$pull_id)"
  echo "::set-env name=BRANCH::$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')"
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *skipped*)"
elif [[ $actions_workflow == release ]]; then
  github_actor=$5
  echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *skipped*)"

  if [[ $github_actor == "pr-scheduler[bot]" ]]; then
    echo "::set-env name=ACTOR_ICON::https://i.imgur.com/tmdeggv.png"
  else
    echo "::set-env name=ACTOR_ICON::https://github.com/$github_actor.png"
  fi
fi

if [[ $actions_workflow == release ]] || [[ $actions_workflow == cron ]]; then
  echo "::set-env name=BRANCH::$(echo $github_ref | sed -E 's|refs/[a-zA-Z]+/||')"
fi

echo "::set-env name=BUILD_URL::$(echo https://github.com/$github_repo/actions/runs/$actions_run_id)"
