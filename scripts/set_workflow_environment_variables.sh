#!/bin/bash

# These variables must be provided to this script in the same order as listed here
args="$*"
event_name=$(echo $args | cut -d " " -f 1)
repository=$(echo $args | cut -d " " -f 2)
run_id=$(echo $args | cut -d " " -f 3)
author=$(echo $args | cut -d " " -f 4)
ref=$(echo $args | cut -d " " -f 5)
head_ref=$(echo $args | cut -d " " -f 6)

if [[ $ref == 'refs/pull'* ]]; then # this is a pull request
  pull_id=$(echo $ref | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
  build_message_addition=" in PR <https://github.com/$repository/pull/$pull_id|#$pull_id>"
  branch=$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')
else
  build_message_addition=""
  branch=$(echo $ref | sed -E 's|refs/[a-zA-Z]+/||')
fi

echo "branch=$branch" >> $GITHUB_ENV
echo "build_message=Build <https://github.com/$repository/actions/runs/$run_id|$run_id> on branch \`$branch\`$build_message_addition" >> $GITHUB_ENV

if [[ $event_name == "schedule" ]]; then # this is a cron
  echo "author_name=github-actions[bot]" >> $GITHUB_ENV
  echo "author_icon=https://i.imgur.com/kUxzV44s.png" >> $GITHUB_ENV
else
  echo "author_name=$author" >> $GITHUB_ENV

  if [[ $author == "pr-scheduler[bot]" ]]; then
    echo "author_icon=https://i.imgur.com/tmdeggv.png" >> $GITHUB_ENV
  else
    echo "author_icon=https://github.com/$author.png" >> $GITHUB_ENV
  fi
fi

# if [[ $event_name == "push" ]] && [[ $ref == "refs/heads/main" ]]; then # push commits to the 'main' branch
  echo "deploy_message= Deploy to GitHub Pages was *skipped* (default message)." >> $GITHUB_ENV
# else
#   echo "deploy_message=" >> $GITHUB_ENV
# fi
