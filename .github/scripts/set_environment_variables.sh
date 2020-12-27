#!/bin/bash

# These variables must be provided to this script in the same order as listed here
args="$*"
event_name=$(echo $args | cut -d " " -f 1)
repository=$(echo $args | cut -d " " -f 2)
run_id=$(echo $args | cut -d " " -f 3)
author=$(echo $args | cut -d " " -f 4)
ref=$(echo $args | cut -d " " -f 5)
head_ref=$(echo $args | cut -d " " -f 6)

echo "Head Ref: $head_ref"
echo "Ref: $ref"

if [[ $ref == "refs/pull"* ]]; then # this is a pull request
  pull_id=$(echo $ref | sed -E "s|refs/pull/||" | sed -E "s|/merge||")
  build_message_addition=" in PR <https://github.com/$repository/pull/$pull_id|#$pull_id>"
  branch=$(echo $head_ref | sed -E "s|refs/[a-zA-Z]+/||")
else
  build_message_addition=""
  branch=$(echo $ref | sed -E "s|refs/[a-zA-Z]+/||")
fi

echo "BRANCH=$branch" >> $GITHUB_ENV
echo "BUILD_MESSAGE=Build <https://github.com/$repository/actions/runs/$run_id|$run_id> on branch \`$branch\`$build_message_addition" >> $GITHUB_ENV

if [[ $event_name == "schedule" ]]; then # this is a cron
  echo "AUTHOR_NAME=github-actions[bot]" >> $GITHUB_ENV
  echo "AUTHOR_ICON=https://i.imgur.com/kUxzV44s.png" >> $GITHUB_ENV
else
  echo "AUTHOR_NAME=$author" >> $GITHUB_ENV

  if [[ $author == "pr-scheduler[bot]" ]]; then
    echo "AUTHOR_ICON=https://i.imgur.com/tmdeggv.png" >> $GITHUB_ENV
  else
    echo "AUTHOR_ICON=https://github.com/$author.png" >> $GITHUB_ENV
  fi
fi

if [[ $event_name == "push" ]] && [[ $ref == "refs/heads/main" ]]; then # this is a push commit to the main branch
  echo "DEPLOY_MESSAGE= Deploy to GitHub Pages was *skipped*." >> $GITHUB_ENV
else
  echo "DEPLOY_MESSAGE=" >> $GITHUB_ENV
fi
