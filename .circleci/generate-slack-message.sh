#!/bin/bash
if [ -z $CIRCLE_PULL_REQUESTS ]; then # pull request does not exist
  if [ -z $CIRCLE_USERNAME ]; then # committer user does not exist
    m="Build #$CIRCLE_BUILD_NUM of $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME:\`$CIRCLE_BRANCH\`"
  else # committer user does exist
    m="Build #$CIRCLE_BUILD_NUM of $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME:\`$CIRCLE_BRANCH\` by $CIRCLE_USERNAME"
  fi
else # pull request does exist
  PR_NUM=$(echo $CIRCLE_PULL_REQUEST | sed 's/.*\///')
  if [ -z $CIRCLE_USERNAME ]; then # committer user does not exist
    m="Build #$CIRCLE_BUILD_NUM of $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME:\`$CIRCLE_BRANCH\` in PR #$PR_NUM"
  else # committer user does exist
    m="Build #$CIRCLE_BUILD_NUM of $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME:\`$CIRCLE_BRANCH\` in PR #$PR_NUM by $CIRCLE_USERNAME"
  fi
fi

echo $m
echo "export SLACK_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
