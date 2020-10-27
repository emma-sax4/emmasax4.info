#!/bin/bash

actions_workflow=$1
github_repo=$2
github_ref=$3
actions_run_id=$4

if [[ $actions_workflow == develop ]]; then
  head_ref=$5
  pull_id=$(echo $github_ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')

  echo "PULL_ID=$pull_id" >> $GITHUB_ENV
  echo "PULL_URL=https://github.com/$github_repo/pull/$pull_id" >> $GITHUB_ENV
  echo "BRANCH=$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')" >> $GITHUB_ENV
elif [[ $actions_workflow == release ]]; then
  github_actor=$5
  echo "DEPLOY_MESSAGE=Deploy to GitHub Pages was *skipped*" >> $GITHUB_ENV

  if [[ $github_actor == "pr-scheduler[bot]" ]]; then
    echo "ACTOR_ICON=https://i.imgur.com/tmdeggv.png" >> $GITHUB_ENV
  else
    echo "ACTOR_ICON=https://github.com/$github_actor.png" >> $GITHUB_ENV
  fi
fi

if [[ $actions_workflow == release ]] || [[ $actions_workflow == cron ]]; then
  echo "BRANCH=$(echo $github_ref | sed -E 's|refs/[a-zA-Z]+/||')" >> $GITHUB_ENV
fi

echo "BUILD_URL=https://github.com/$github_repo/actions/runs/$actions_run_id" >> $GITHUB_ENV
