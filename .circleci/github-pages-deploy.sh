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
git push origin master
