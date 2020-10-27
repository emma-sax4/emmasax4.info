#!/bin/bash

args="$*"
deploy=$(echo "$args" | grep -o 'deploy=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#') # 'true' or 'false'
github_repo=$(echo "$args" | grep -o 'github_repo=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
actions_run_id=$(echo "$args" | grep -o 'actions_run_id=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
github_actor=$(echo "$args" | grep -o 'github_actor=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
github_ref=$(echo "$args" | grep -o 'github_ref=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
head_ref=$(echo "$args" | grep -o 'head_ref=[^[:blank:]]*' | sed -e 's#.*=\(\)#\1#')
build_url="https://github.com/$github_repo/actions/runs/$actions_run_id"

if [[ $head_ref == "" ]]; then # branch is 'main'
  branch=$(echo $github_ref | sed -E 's|refs/[a-zA-Z]+/||')

  echo "build_message=Build <$build_url|$actions_run_id> on branch \`$branch\`" >> $GITHUB_ENV
  echo "deploy_message=$(cat deploy-status-message.txt)" >> $GITHUB_ENV

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
  branch=$(echo $head_ref | sed -E 's|refs/[a-zA-Z]+/||')

  echo "build_message=Build <$build_url|$actions_run_id> on branch \`$branch\` in PR <$pull_url|#$pull_id>" >> $GITHUB_ENV
  echo "actor_name=$github_actor" >> $GITHUB_ENV
  echo "actor_icon=https://github.com/$github_actor.png" >> $GITHUB_ENV
fi
