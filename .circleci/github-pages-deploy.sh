#!/bin/bash
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout master
git pull origin master

find . -maxdepth 1 ! -name "_site" ! -name ".git" ! -name ".circleci" -exec rm -rf {} \;
mv ./_site/* .
rm -R ./_site/

git add -fA
# git commit -m "Deploy to $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME.git:master via CircleCI"
# PUSH_STATUS=$(git push origin master 2>&1)

# if [[ $PUSH_STATUS == "Everything up-to-date" ]]; then
  m="Nothing to commit to \`master\` branch. Deploy to GitHub Pages was *skipped*"
# else
#   m="Deploy to GitHub Pages was *successful*"
# fi

echo "export DEPLOY_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
