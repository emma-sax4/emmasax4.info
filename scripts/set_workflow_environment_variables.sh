#!/bin/bash

# These variables must be provided to this script in the same order as listed here
event_name=$1
repository=$2
run_id=$3
gh_actor=$4
gh_ref=$5
head_ref=$6

echo "event:$event_name"
echo "repository:$repository"
echo "run_id:$run_id"
echo "gh_actor:$gh_actor"
echo "gh_ref:$gh_ref"
echo "head_ref:$head_ref"


build_url="https://github.com/$repository/actions/runs/$run_id"

if [[ $gh_ref == 'refs/pull'* ]]; then # this is a pull request
  pull_id=$(echo $gh_ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
  pull_url="https://github.com/$repository/pull/$pull_id"
  build_message_addition=" in PR <$pull_url|#$pull_id>"
  branch=$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')
else
  build_message_addition=""
  branch=$(echo $gh_ref | sed -E 's|refs/[a-zA-Z]+/||')
fi

echo "branch=$branch" >> $GITHUB_ENV
echo "build_message=Build <$build_url|$run_id> on branch \`$branch\`$build_message_addition" >> $GITHUB_ENV

if [[ $event_name == "schedule" ]]; then # this is a cron
  echo "author_name=github-actions[bot]" >> $GITHUB_ENV
  echo "author_icon=https://i.imgur.com/kUxzV44s.png" >> $GITHUB_ENV
else
  echo "author_name=$gh_actor" >> $GITHUB_ENV

  if [[ $gh_actor == "pr-scheduler[bot]" ]]; then
    echo "author_icon=https://i.imgur.com/tmdeggv.png" >> $GITHUB_ENV
  else
    echo "author_icon=https://github.com/$gh_actor.png" >> $GITHUB_ENV
  fi
fi
