#!/bin/bash
if [ -z $CIRCLE_PULL_REQUESTS ]; then # pull request does not exist
  if [ -z $CIRCLE_USERNAME ]; then # committer user does not exist
    m="Build #$CIRCLE_BUILD_NUM of \`$CIRCLE_PROJECT_REPONAME\` on _branch_ $CIRCLE_BRANCH"
  else # committer user does exist
    m="Build #$CIRCLE_BUILD_NUM of \`$CIRCLE_PROJECT_REPONAME\` on _branch_ $CIRCLE_BRANCH by $CIRCLE_USERNAME"
  fi
else # pull request does exist
  if [ -z $CIRCLE_USERNAME ]; then # committer user does not exist
    m="Build #$CIRCLE_BUILD_NUM of \`$CIRCLE_PROJECT_REPONAME\` on _branch_ $CIRCLE_BRANCH in PR $CIRCLE_PULL_REQUESTS"
  else # committer user does exist
    m="Build #$CIRCLE_BUILD_NUM of \`$CIRCLE_PROJECT_REPONAME\` on _branch_ $CIRCLE_BRANCH in PR $CIRCLE_PULL_REQUESTS by $CIRCLE_USERNAME"
  fi
fi

echo "export SLACK_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
