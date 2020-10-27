#!/bin/bash

deploy=$(sed -e 's#.*=\(\)#\1#' <<< $1) # 'true' or 'false'
github_repo=$(sed -e 's#.*=\(\)#\1#' <<< $2)
actions_run_id=$(sed -e 's#.*=\(\)#\1#' <<< $3)
github_actor=$(sed -e 's#.*=\(\)#\1#' <<< $4)
github_ref=$(sed -e 's#.*=\(\)#\1#' <<< $5)
head_ref=$(sed -e 's#.*=\(\)#\1#' <<< $6)

build_url="https://github.com/$github_repo/actions/runs/$actions_run_id"

if [[ $head_ref == "" ]]; then # branch is 'main'
  branch=$(echo $github_ref | sed -E 's|refs/[a-zA-Z]+/||')
  echo "branch=$branch" >> $GITHUB_ENV
  echo "deploy_message=Deploy to GitHub Pages was *skipped*" >> $GITHUB_ENV
  echo "build_message=Build <$build_url|$actions_run_id> on branch `$branch`" >> $GITHUB_ENV

  if [[ $deploy == "true" ]]; then
    echo "actor_name=$github_actor" >> $GITHUB_ENV

    if [[ $github_actor == "pr-scheduler[bot]" ]]; then
      echo "actor_icon=https://i.imgur.com/tmdeggv.png" >> $GITHUB_ENV
    else
      echo "actor_icon=https://github.com/$github_actor.png" >> $GITHUB_ENV
    fi
  else # this is a cron
    echo "actor_name=github-actions[bot]" >> $GITHUB_ENV
    echo "actor_icon=https://i.imgur.com/kUxzV44s.png" >> $GITHUB_ENV
  fi
else
  pull_id=$(echo $github_ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
  pull_url="https://github.com/$github_repo/pull/$pull_id"
  branch=$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||') # this comes to '' if on 'main' branch
  echo "branch=$branch" >> $GITHUB_ENV
  echo "build_message=Build <$build_url|$actions_run_id> on branch `$branch` in PR <$pull_url|#$pull_id>" >> $GITHUB_ENV
  echo "actor_name=$github_actor" >> $GITHUB_ENV
  echo "actor_icon=https://github.com/$github_actor.png" >> $GITHUB_ENV
fi
