#!/bin/bash
m="Build #$GITHUB_RUN_ID of $GITHUB_REPOSITORY"

if [[ $GITHUB_REF != "source" ]]; then
  m="$m on branch \`$GITHUB_REF\`"
fi

if [ ! -z $GITHUB_ACTOR ]; then
  m="$m by $GITHUB_ACTOR"
fi

echo "export SLACK_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
