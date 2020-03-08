#!/bin/bash
m="Build <$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM> of $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME"

if [[ $CIRCLE_BRANCH != "source" ]]; then
  m="$m on branch \`$CIRCLE_BRANCH\`"
fi

if [ ! -z $CIRCLE_PULL_REQUEST ]; then
  PR_NUM=$(echo $CIRCLE_PULL_REQUEST | sed 's/.*\///')
  m="$m in PR <$CIRCLE_PULL_REQUEST|#$PR_NUM>"
fi

if [ ! -z $CIRCLE_USERNAME ]; then
  m="$m by $CIRCLE_USERNAME"
fi

echo "export SLACK_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
