#!/bin/bash
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout master
git pull origin master

find . -maxdepth 1 ! -name "site" ! -name ".git" ! -name ".circleci" -exec rm -rf {} \;
mv ./site/* .
rm -R ./site/

git add -fA
git commit -m "Deploy to emma-sax4/emma-sax4.github.io.git:master via CircleCI"
PUSH_STATUS=$(git push origin master 2>&1)

if [[ $PUSH_STATUS == "Everything up-to-date" ]]; then
  m="Nothing to commit to master. Skipped deploy to GitHub Pages"
else
  m="Successfully deployed to GitHub Pages"
fi

echo "export DEPLOY_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
