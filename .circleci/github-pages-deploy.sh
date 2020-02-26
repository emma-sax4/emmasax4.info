#!/bin/bash
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout master
git pull origin master

find . -maxdepth 1 ! -name './site' -exec rm -rf {} \;
mv ./site/* .
rm -R ./site/

git add -fA
git commit --allow-empty -m "Deploy to github.com/emma-sax4/emma-sax4.github.io.git:master via CircleCI"
git push origin master

echo "GitHub Pages deploy completed successfully."
