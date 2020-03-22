---
layout: post
title: Why I Switched from Travis CI to CircleCI
tags: [ tech, jekyll ]
permalink: /blog/posts/why-i-switched-from-travis-ci-to-circleci/
date: 2020-03-22 12:51:00 -0500
---

About three weeks ago, I started my next goal on this website, and that was to slowly move my website's building and testing from [Travis CI](https://travis-ci.org/) to [CircleCI](https://circleci.com/). In this post, I'd like to explain what I use continuous integration (CI) tools for, why I switched third-party tools, and what I liked and disliked about each of them.

* Table of Contents
{:toc}

## My Use Case for CI Tools

The initial reason why I used Travis CI as my integration tool is outlined in [this blog post](/blog/posts/using-jekyll-paginate-v2/). But, as my website has continued to develop, there are four basic things I want my CI platform to be able to do for me:
1. Build my Jekyll website quickly, run HTML Proofer on it, and have room to grow my test suite if I desire to do so
2. Notify a Slack channel when the build was done
3. "Deploy" my website by making a commit back to my [`master` branch in GitHub](https://github.com/emma-sax4/emma-sax4.github.io/tree/master) (which GitHub Pages will then deploy for me)
4. Run a daily cron so that I can automate the build to run whenever I want (ideal for when I'd like to publish a blog post at a specific time, which involves having my CI tool run a job at that time)

Travis CI can do all four of these things, and some of them were easier to set up than with CircleCI! I'll walk through that in a bit. But there was a big issue that I had with Travis CI. And at the end of the day, that was the reason I searched for other CI solutions. That issue was number four: setting up crons.

## Travis CI

[Travis CI](https://travis-ci.org/) is probably one of the most popular CI tools out there. It is almost designed to work with GitHub, with the idea that upon committing to GitHub, it will trigger a _build_ in Travis CI. That build is configurable inside each GitHub repository, defined in a `.travis.yml` file in the root directory of the repo. The build can install dependencies, build a container of your project, run tests, deploy to a variety of web service platforms (such as AWS, GitHub Pages, Azure, Heroku, etc), and a bunch of other stuff. Their builds are highly configurable and extremely flexible.

Travis CI also offers free and paid plans. On a personal level, I'm on the free plan, but in exchange, I can only run a certain amount of builds at the same time. For relatively small projects like mine, that's enough. Most companies that utilize Travis CI will have an enterprise or paid plan to have more build capacity.

### 1. Building my website

Building my Jekyll website using Travis CI was extremely easy. It looked something like this:
```yaml
script:
  - JEKYLL_ENV=production bundle exec jekyll build --destination ./site
  - htmlproofer --assume-extension --allow-hash-href --internal-domains /emmasax4.info/ ./site
```

The `script` is one of the [job lifecycle](https://docs.travis-ci.com/user/job-lifecycle/) phases. This `script` section is where I could build the project, run tests, etc. For my site, I wanted to try running [HTML Proofer](https://github.com/gjtorikian/html-proofer), hence the second `script` line.

Overall, running the website and getting this project up and running with Travis CI was simple and painless. The one sore point was that installing the gem dependencies using `bundler` never quite cached correctly. Because of this, when Travis CI ran `bundle install`, it would always take a minute of compute time just to install the gems. If they were cached correctly, all of my builds would've been much faster. This was never something that I cared enough to fix, but was just an annoyance.

### 2. Notifying Slack

Whenever my builds on Travis CI finished, I wanted to be notified via Slack. This way I could have the Slack app installed on my mobile device, and make sure my builds pass from anywhere, with notifications. Setting up Travis CI to notify Slack was easy:
```yaml
notifications:
  email: false # Because I don't want my email getting cluttered
  slack:
    on_success: always
    on_failure: always
    on_pull_requests: true
    secure: ENCRYPTED_TOKEN_GOES_HERE
```

From the Slack side, to get started, I filled out the basic instructions documented [here](https://docs.travis-ci.com/user/notifications/#configuring-slack-notifications). The only huge hiccup I found was when it came to encrypting the secure token value. When I used the unencrypted version (`<MY_DOMAIN>:<MY_TOKEN>`) as the Slack value, notifications worked, but I didn't like the idea of my unencrypted information being in a public GitHub repository. But when I tried to use the `secure` encrypted value, it didn't send any notifications. The solution I found was to use the `--pro` flag:
```bash
travis encrypt --pro "<MY_DOMAIN>:<MY_TOKEN>"
```

I'm not sure why this was necessary, as my project isn't a private repository. But perhaps it triggered the encryption to use `travis-ci.com` instead of `travis-ci.org` or something like that.

### 3. "Deploying" to GitHub Pages

The [original blog post I found](https://medium.com/@mcred/supercharge-github-pages-with-jekyll-and-travis-ci-699bc0bde075) nicely outlines (in lots of words) how to deploy to GitHub Pages from Travis CI. The gist is that we use a Travis CI deploy to make a GitHub commit to the `master` branch of your project repository. In this way, you'll have at least two main branches on your repository: a `master` branch that GitHub Pages reads from, with only HTML and other site files, and a source code branch (your default branch) which will contain documentation, markdown files, Jekyll configs, etc. [Here's the documentation](https://docs.travis-ci.com/user/deployment-v2/providers/pages/) from Travis CI on GitHub Pages deploys on dpl v2.
```yaml
deploy:
  provider: pages
  name: Deployment Bot
  email: deploy@travis-ci.org
  target_branch: master
  commit_message: Deploy to %{url}:%{target_branch}
  local_dir: ./site
  keep_history: true
  edge: true
  on:
    branch: SOURCE_CODE_BRANCH
  token:
    secure: ENCRYPTED_TOKEN_GOES_HERE
```

If all you do is copy my code above, the `SOURCE_CODE_BRANCH` is to reference which branch on GitHub you want Travis to run this command on (in my case, it was my `source` branch). The `ENCRYPTED_TOKEN_GOES_HERE` indicates the encrypted value of your GitHub personal access token, which grants Travis CI permission to deploy to your repository. In order to generate the encrypted token, I ran:
```bash
travis encrypt "PERSONAL_ACCESS_TOKEN"
```

### 4. Running daily crons

Up until this point, setting up the `.travis.yml` has maybe only taken about 4–6 hours of my time. Not too bad. Setting up the crons won't take long either. But, this is where I'll start having to compromise a bit more. Travis CI does have basic configuration for [cron jobs](https://docs.travis-ci.com/user/cron-jobs/). But cron functionality is limited.

They aren't codified at all, and are instead set up directly in the Travis CI browser. Cron jobs aren't set at a particular time, but instead, you just set it to run daily, weekly, or monthly. To figure out what time you want them to run, you need to physically press the `Add` button, and then wait a few minutes, and then one will start. From doing some reading, the cron will run on the schedule set, beginning within one hour of when you press the button. I'm assuming this has something to do with job availability and capacity.

So I wanted to set up a cron to run at midnight. For me to configure it to be set at midnight, I had to physically press the `Add` button at 11:55pm. From there on, it would run daily, but may start at 11:55pm, or it may start at 12:30am, or pretty much any time in between. I really did not like this functionality. It may be fine for somebody that just wants the tests to run sometime during the night. But since I'm using those crons to release blog posts at pretty specific times, I want my builds to run at exact times. Furthermore, as the days went on with me using this cron, the start time seemed to be pushed back later and later (I'd get a Slack message when the build was done, so I'd know when it started).

So, to sum it all up, setting up crons was easy. But I didn't like how they weren't codified and how they were very inexact.

## CircleCI

Here's where [CircleCI](https://circleci.com/docs/2.0/about-circleci/) enters the picture. I originally heard about CircleCI from a DevOpsDays conference, where they had a sponsorship booth. After talking to them a bit, it seemed really interesting. They claimed CircleCI could do very similar things that Travis CI could do, but _easier?_ So, when I found that I was really not liking the cron functionality on Travis CI, I did some initial research on CircleCI. Can CircleCI do all four of the items on my checklist? Yes. Do they all look relatively simple to set up? Yes. So, that was enough reassurance that I could start to make a CircleCI integration. I'd leave the Travis CI one around, so if something didn't work out, I'd still be just fine with Travis CI.

CircleCI builds are also fully configurable in a file called `.circleci/config.yml`. This file is placed in a directory. At first I wasn't quite sure if I liked placing the file there, but having a whole directory ended up being handy. This gave me an easy place to put all sorts of other bash files that I'd eventually call from the `config.yml`, without having to make a new directory or clutter up the root.

### 1. Building my website

To build my website in CircleCI, I set up a simple [workflow](https://circleci.com/docs/2.0/configuration-reference/#workflows). I did this so that I could have separate flow of the build for different branches (development feature branch, source code branch, `master` branch, etc).

Here's my first workflow:
```yaml
workflows:
  version: 2
  develop:
    jobs:
    - test:
        filters:
          branches:
            ignore: [ SOURCE_CODE_BRANCH ]
```

Here, I've named a `develop` workflow which will run the job `test`, on any branch that is not the `SOURCE_CODE_BRANCH`. One thing I don't really like about CircleCI's config files is how nested they are. It's yaml, so there's a way to write the code not nested, but it involves a lot of nested brackets and braces. I eventually decided to just deal with the nested yaml, and to move on.

From there, this is what my `test` job looks like:
```yaml
jobs:
  test:
    working_directory: ~/PROJECT_NAME
    docker: [ image: circleci/RUBY_IMAGE ]
    steps:
    - checkout # This is so the build goes into your working_directory
    - configure_bundler
    - jekyll_build
    - html_proofer
```

The `working_directory` indicates the name of your project, so that when your job does its `checkout` step, it'll go into that directory. I've set a Ruby image so that CircleCI knows what docker container to run my build in. And then, I define each step as a command.

```yaml
commands:
  configure_bundler:
    steps:
    - run:
        name: Configure Bundler
        command: {% raw %}.circleci/configure-bundler.sh{% endraw %}
    - restore_cache: # Properly cache my gem dependencies based on the Gemfile.lock version
        key: {% raw %}bundler-cache-{{ checksum "Gemfile.lock" }}{% endraw %}
    - run:
        name: Bundle Install
        command: {% raw %}bundle install --path vendor/bundle{% endraw %}
    - save_cache: # Save the cache again, for next time around
        key: {% raw %}bundler-cache-{{ checksum "Gemfile.lock" }}{% endraw %}
        paths: [ vendor/bundle ]
  jekyll_build:
    steps:
    - run:
        name: Jekyll Build
        command: {% raw %}JEKYLL_ENV=production bundle exec jekyll build --destination ./_site/{% endraw %}
  html_proofer:
    steps:
    - run:
        name: HTML Proofer
        command: {% raw %}.circleci/html-proofer.sh{% endraw %}
```

Just by setting these `restore_cache` and `save_cache` steps, my builds sped up compared to Travis CI. When the dependencies are cached, the entire `configure_bundler` command now takes about 8 seconds. When the dependencies are not cached, it may take a bit longer than Travis CI to install everything (about 2 minutes), but waiting 2 minutes less frequently is worth it to have faster builds in general.

Here are the additional files that these steps call.

`.circleci/configure-bundler.sh` is called in the `configure_bundler` command. This file grabs the `bundler` version from the `Gemfile.lock`, and then installs that version of `bundler`.
```bash
#!/bin/bash
echo "export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d ' ')" >> $BASH_ENV
source $BASH_ENV
gem install bundler
```

`.circleci/html-proofer.sh` is called in the `html_proofer` command. This file will just run [HTML Proofer](https://github.com/gjtorikian/html-proofer) on the command line.
```bash
#!/bin/bash
{% raw %}bundle exec htmlproofer \
    --assume-extension \
    --allow-hash-href \
    --internal-domains /emmasax4.info/ \
    ./_site/{% endraw %}
```

### 2. Notifying Slack

To notify Slack, I set up the [Slack orb](https://circleci.com/orbs/registry/orb/circleci/slack). I still don't really understand the purpose of orbs, but this slack one wasn't too difficult to use. Here's my configuration which will send a notification message when my build is finished:
```yaml
commands:
  set_slack_message:
    steps:
    - run:
        name: Slack - Generating Custom Message
        command: {% raw %}.circleci/generate-slack-message.sh{% endraw %}
  slack_build_notification:
    steps:
    - slack/status:
        success_message: "$SLACK_MESSAGE *passed*."
        failure_message: "$SLACK_MESSAGE *failed*."
        include_job_number_field: false
        include_project_field: false
        include_visit_job_action: false
jobs:
  test:
    steps:
    - set_slack_message
    - slack_build_notification
```

The orb comes with a default Slack message, but I wanted to customize mine a bit. So I set a custom message in a `.circleci/generate-slack-message.sh` file:
```bash
#!/bin/bash

# Start with a link to the CircleCI build and the project...
m="Build <$CIRCLE_BUILD_URL|#$CIRCLE_BUILD_NUM> of $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME"

# If the branch of the build is NOT the source code branch, then write the branch
if [[ $CIRCLE_BRANCH != "SOURCE_CODE_BRANCH_NAME" ]]; then
  m="$m on branch \`$CIRCLE_BRANCH\`"
fi

# If the build is a pull request, then write the PR number and add a link to it
if [ ! -z $CIRCLE_PULL_REQUEST ]; then
  PR_NUM=$(echo $CIRCLE_PULL_REQUEST | sed 's/.*\///')
  m="$m in PR <$CIRCLE_PULL_REQUEST|#$PR_NUM>"
fi

# If there is a GitHub user who ran this build, then write the username
if [ ! -z $CIRCLE_USERNAME ]; then
  m="$m by $CIRCLE_USERNAME"
fi

echo "export SLACK_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
```

With this, a final message will include all of the information I'd like to see when a CircleCI build finishes:

> {% raw %}Build [#538](https://example.com) of github-user/github-repo on branch `branch_name` in PR [#201](https://example.com) by github-user passed.{% endraw %}

To set up credentials, I added a custom CircleCI [Slack app](https://api.slack.com/messaging/webhooks#getting_started) on my Slack account. This Slack app can post to specific channels via an incoming webhook. From the incoming webhook, they gave me a secure URL to post back to, and I added that as a CircleCI environment variable. Voilà!

### 3. "Deploying" to GitHub Pages

Setting up the "deploy" to GitHub Pages consisted of defining a new workflow, job, and command. I set up the new workflow so that I could separate when the deploy job would be run, since there's no need to run it on the `develop` workflow:

```yaml
workflows:
  version: 2
  release:
    jobs:
    - test-and-deploy:
        filters:
          branches:
            only: [ SOURCE_CODE_BRANCH ]
jobs:
  test-and-deploy:
    working_directory: ~/PROJECT_NAME
    docker: [ image: circleci/RUBY_IMAGE ]
    steps:
    - checkout # this is so the build goes into your working_directory
    - configure_bundler
    - jekyll_build
    - github_pages_deploy
    - slack_build_notification
commands:
  github_pages_deploy:
    steps:
    - add_ssh_keys:
        fingerprints: [ a1:a2:a3:a4:a5:a6:a7:a8:a9:b1:b2:b3:b4:b5:b6:b7 ]
    - deploy:
        name: Deploy to GitHub Pages
        command: {% raw %}.circleci/github-pages-deploy.sh{% endraw %}
```

This workflow titled `release` will only run on the `SOURCE_CODE_BRANCH`. It will still build the Jekyll site, so there's something to deploy, and it will still notify Slack upon completion. But, we've defined a new command for the job to run, `github_pages_deploy`, which will call the `.circleci/github-pages-deploy.sh` file:
```bash
#!/bin/bash

# These are two variables that I added as CircleCI environment variables
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout master # or whatever branch GitHub Pages reads from
git pull origin master

# NOTE: the Jekyll build command added the entire site to the _site directory...
# Delete everything except the _site, .git, and .circleci directories
find . -maxdepth 1 ! -name "_site" ! -name ".git" ! -name ".circleci" -exec rm -rf {} \;
# Move the _site directory contents into the root directory
mv ./_site/* .
# Delete the _site directory, as it's now empty
rm -R ./_site/

# Now make a deploy to the master branch and push!
git add -fA
git commit -m "Deploy to $CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME.git:master via CircleCI"
PUSH_STATUS=$(git push origin master 2>&1)

# Write a brief message to output to Slack so I know whether this deploy occurred or not
if [[ $PUSH_STATUS == "Everything up-to-date" ]]; then
  m="Nothing to commit to \`master\` branch. Deploy to GitHub Pages was *skipped*"
else
  m="Deploy to GitHub Pages was *successful*"
fi

echo "export DEPLOY_MESSAGE='$m'" >> $BASH_ENV
source $BASH_ENV
```

Uffda. That was a big file. And I'd be lying if I said that I didn't accidentally delete the whole site a couple of times while I tried to figure out how this file should work. But at the end of the day, this code works perfectly for what I needed.

The last piece was to set up a GitHub deploy key for my project with read/write permissions. I followed a mixture of the instructions located [here](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys) and [here](https://circleci.com/docs/2.0/gh-bb-integration/#creating-a-github-deploy-key). After I obtained that (it looked like an SSH key), then I could provide that to CircleCI so it'd have proper permissions to commit to `master` branch. Then, I just added the fingerprint to my build and I was ready to go!
```yaml
- add_ssh_keys:
    fingerprints: [ a1:a2:a3:a4:a5:a6:a7:a8:a9:b1:b2:b3:b4:b5:b6:b7 ]
```

### 4. Running daily crons

Up until this point, setting CircleCI up was substantially more difficult for me than setting up Travis CI. Part of that may be because CircleCI is less popular than Travis CI, so there's less support on the internet. However, when I reached out to CircleCI customer service to ask a question, they got back to me within a day, and were very polite and helpful—an experience I never had with Travis CI.

But for me, setting up daily crons was probably the easiest part of this entire journey:
```yaml
workflows:
  version: 2
  cron:
    jobs: [ test-and-deploy ]
    triggers:
    - schedule:
        cron: "30 5 * * *" # 05:30 UTC => 00:30 CDT / 23:30 CST
        filters:
          branches:
            only: [ SOURCE_CODE_BRANCH ]
```

Because I already defined the job I needed, I simply added this little cron workflow, and it works brilliantly. And I know that my cron builds start exactly when I want them to because I get a nice Slack notification at exactly 05:30 UTC on the dot (my builds are fast now, remember?). I know when looking at the Slack notification whether it was a cron or not, because when a cron runs, there's no GitHub username in the message. And I can add as many or as few crons as I'd like. I simply add more `schedule`s to the `triggers` array in the yaml. And because my whole site "thinks" in UTC time (see more [here](/blog/posts/time-zones-utc-and-javascript-oh-my/)), it's easy to set the crons to whatever specific time I need to publish all of my blog posts automatically.

### Adding a <header-code>config.yml</header-code> to the <header-code>master</header-code> branch

In Travis CI, if there's no `.travis.yml` file, then Travis CI will ignore the commit and it won't run anything. This was useful on branches like the `master` branch, where there's no need to run a build on each commit. In CircleCI, if there's no `.circleci/config.yml` on a branch, it'll still try to run a build, and then break and say there's no config file. So, I manually added this `.circleci/config.yml` to my `master` branch, to completely ignore the branch on each commit:
```yaml
version: 2.1
jobs:
  skip:
    working_directory: ~/PROJECT_NAME
    docker: [ image: circleci/RUBY_IMAGE ]
    steps: [ checkout ] # A simple step otherwise the build breaks with syntax errors
workflows:
  version: 2
  BRANCH_TO_IGNORE:
    jobs:
    - skip:
        filters:
          branches:
            ignore: [ BRANCH_TO_IGNORE ]
```

Now with this, CircleCI will completely ignore my `master` branch.

## Conclusion

As you can see, setting up CircleCI actually did take longer than setting up Travis CI, but I'm not sure if that's because I use Travis CI at my work, and have never used CircleCI before at all. My CircleCI files do have more lines of code, and that goes to show that making one command in CircleCI is going to be a little bit more complex than one "command" in Travis CI. But overall, the speedier caching of gems and more precise codification of the crons make CircleCI a clear winner for this website. The only huge con of CircleCI is that Travis CI is more popular, and so there's more functionality and online support with Travis CI.

But at the end of the day, what matters is that every project uses the CI solution that works best for their needs and their project. For this website, that answer was CircleCI. But for many, that's Travis CI. As long as projects are running tests, that's what matters most.
