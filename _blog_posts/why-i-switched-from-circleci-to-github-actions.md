---
layout: post
title: Why I Switched from CircleCI to GitHub Actions
tags: [ tech ]
permalink: /blog/posts/why-i-switched-from-circleci-to-github-actions/
date: 2020-05-28 00:00:00 -0500
---

A couple of months ago, I made a decision to explore [CircleCI](https://circleci.com/) as a continuous integration (CI) platform. After my exploration, I decided to fully switch over my website from [Travis CI](https://travis-ci.org/) to CircleCI. I wrote a blog post about _why_ I switched [here](/blog/posts/why-i-switched-from-travis-ci-to-circleci/). But two months later, although I was still content overall, something happened that made me think about cutting back on dependencies for my site.

I know my website was still dependent on a lot of things: [GitHub Pages](https://pages.github.com/) to serve my site, [CircleCI](https://circleci.com/) to build and deploy my site, [Bootstrap4](https://getbootstrap.com/docs/4.4/getting-started/introduction/) for its buttons and CSS, [Feather](https://feathericons.com/) for its beautiful icons, [Jquery](https://jquery.com/) for its javascript responsive CSS, etc. So, I made a plan to remove all of those dependencies (crazy, right?!).

If we make the assumption that I've successfully removed all Bootstrap4, Jquery, Feather, and Google Fonts dependencies (by downloading them all raw to my GitHub repository... I know, I'm crazy), then I'm left with one big gaping dependency hole. My site relies on GitHub and CircleCI. And this leads me to describe what prompted me to do all of this.

* [The Story Behind this Extreme Decision](#the-story)
* [How I Use CI Tools](#how-i-use-ci-tools)
* [Here Enters GitHub Actions](#here-enters-github-actions)
  * [1. Building my website](#building-my-website)
  * [2. Notifying Slack](#notifying-slack)
  * [3. "Deploying" to GitHub Pages](#deploying-to-github-pages)
  * [4. Running daily crons](#running-daily-crons)
* [Conclusion](#conclusion)

<div id="anchor">
  <a id="the-story">&nbsp;</a>
</div>

## The Story Behind this Extreme Decision

A few weeks ago, Travis CI had a problem delivering notification webhooks. At my work, we send Travis CI webhooks to one of our internal websites, which then sends Slack notifications and starts deployments to our staging and production environments. And when Travis CI stopped sending our webhooks, we lost all notifications and all deployments—for half a day.

None of us particularly noticed anything was amiss until a few hours had gone by, and the developers realized none of their code had been deployed to our staging environment. After they reported that to my team, I dove into a two-hour tailspin to figure out why our deployments and notifications never arrived. Did our internal website break? Did notification formats change? Was AWS having blips throughout the day? And what we realized was that the issue wasn't ours—it was Travis CI's issue.

After we sent Travis CI support an email, they promptly had the issue tracked on their Status Page, and it was fixed within the hour.

At my workplace, at most this was just a few hours' time and frustration, and a little bit of slowed down development time; annoying, but recoverable. But it prompted my team to think about how interwoven our development process is with multiple third party platforms. We've had similar issues when GitHub has outages, since it prevents us from doing code reviews and deployments. Now, it's happened again with our build and testing tool: Travis CI. If AWS started to have issues, then wouldn't be able to run deployments (ignoring the fact that all of our platforms are hosted through AWS).

If any of our development process tools have an outage, then we are unable to develop.

So, how does this relate to my project? After thinking about it for a while, I didn't like how my website was dependent on GitHub _and_ CircleCI. Up until now, CircleCI has only had one half-outage which caused me a little bit of grief. And when I emailed them, their support help was phenomenal. They took responsibility, explained what went wrong, and fixed it right up. But, I thought that it could be worth it to be brave and try something new: [GitHub Actions](https://github.blog/2019-08-08-github-actions-now-supports-ci-cd/).

Up until now, I've heard of GitHub Actions, but I've been a little bit scared to try it out. I figured that there was no time like the present to give it a shot. If it doesn't work, then I have a CI solution that I'm really perfectly satisfied with and okay sticking with. If it does work out, then I've got a CI solution I'm happy with that _also_ cuts out a third party platform. I won't need to pass secure tokens and secrets around, and I won't need webhooks. GitHub would handle everything, from storing my source code, to building, to deploying, to hosting. And if GitHub has an outage, well my whole site is down anyway, so as long as they're working on fixing it for me, then I'm satisfied 👍🏼.

<div id="anchor">
  <a id="how-i-use-ci-tools">&nbsp;</a>
</div>

## How I Use CI Tools

As I originally outlined in [this blog post](/blog/posts/why-i-switched-from-travis-ci-to-circleci/), I use CI tools for four main things:

> 1. Build my Jekyll website quickly, run HTML Proofer on it, and have room to grow my test suite if I desire to do so
> 2. Notify a Slack channel when the build was done
> 3. "Deploy" my website by making a commit back to my [`gh-pages` branch in GitHub]({{ site.github_repo }}/tree/gh-pages) (which GitHub Pages will then deploy for me)
> 4. Run a daily cron so that I can automate the build to run whenever I want (ideal for when I'd like to publish a blog post at a specific time or to check that my site still builds and loads properly every now and then, since my site doesn't get consistent updates all the time)

This list of four requirements hasn't changed. CircleCI can do all of these things beautifully, although if I'm honest, I had to do some of my own personal fidgeting around to get #3 working as expected and #2 with a custom Slack message. All of this is fine. I put the time and effort in once, and it's paid off countless times since. #automation #computers. Now it's time to see if GitHub Actions can do the same things for me.

<div id="anchor">
  <a id="here-enters-github-actions">&nbsp;</a>
</div>

## Here Enters GitHub Actions

On the surface, GitHub Actions is _very_ similar to CircleCI. Both of them use Yaml, and both of them use workflows which have multiple jobs, and jobs have multiple steps/commands. Both of them require a `checkout` step, and both of them have capabilities to run on a schedule or on `push`.

The immediate first thing I noticed was that GitHub Actions requires you to have a separate file for each workflow. In concept this idea is fine, but this is made 10x worse by the fact that you can't have steps that are shared between jobs/workflows. So each workflow I define must define each job on its own. This is sort of annoying given the fact that my three workflows `Develop`, `Release`, and `Cron` all share nine steps. This means that those three workflow files have _a lot_ of duplicated code on them. This would be cumbersome if I changed my workflow files a lot, so the good news is that I don't forsee them changing every week.

So besides needing a separate workflow file for each workflow, let's jump in to each requirement individually.

<div id="anchor">
  <a id="building-my-website">&nbsp;</a>
</div>

### 1. Building my website

The first step in each workflow is to `checkout` the code. GitHub Actions provides a [Checkout Action](https://github.com/actions/checkout) that's made to do exactly that. So there, we have our first few steps:

```yml
{% raw %}jobs:
  job-name:
    runs-on: ubuntu-latest # Linux is the best
    steps:
    - name: Checkout Code
      uses: actions/checkout@v1

    # we'll see the other custom defined environment variables later
    # get the current branch based off github.head_ref OR github.ref (if we're running this on a branch vs. a PR)
    - name: Define Variables
      run: echo "::set-env name=BRANCH::$(echo ${{ github.head_ref }} | sed -E 's|refs/[a-zA-Z]+/||')"

    - name: Switch to Current Branch
      run: git checkout ${{ env.BRANCH }}{% endraw %}
```

Technically the Checkout Action provides a `v2` to use, but I found that it doesn't work for what I wanted. I'll explain more about that later. So to bypass those issues, I paired the checkout step with the `Switch to Current Branch` step to get around that issue.

The next few steps are to set up Bundler, install gems, and build the site. I'll just give these steps instead of explaining:

```yml
{% raw %}# install the exact version of bundler that the Gemfile.lock uses
- name: Configure Bundler
  run: sudo gem install bundler -v $(cat Gemfile.lock | tail -1 | tr -d ' ')

# use https://github.com/actions/cache to set a gem cache
- name: Configure Gem Cache
  uses: actions/cache@v1
  with:
    path: vendor/bundle
    key: bundler-cache-${{ hashFiles('**/Gemfile.lock') }}
    restore-keys: bundler-cache-

# install all gems or use the cached gems
- name: Install Gems
  run: bundle config set path 'vendor/bundle' && bundle install

# build the site
- name: Jekyll Build
  run: JEKYLL_ENV=production bundle exec jekyll build --destination _site

# run HTML proofer
- name: HTML Proofer
  run: bundle exec htmlproofer --assume-extension --allow-hash-href --internal-domains /emmasax4.com/ --only_4xx _site{% endraw %}
```

Bam! Not too shabby. This now looks _very_ familiar to CircleCI.

<div id="anchor">
  <a id="notifying-slack">&nbsp;</a>
</div>

### 2. Notifying Slack

It turns out that GitHub Actions uses actions similarly to how CircleCI uses orbs. So, I went and hunted down the perfect action for slack notifications. I ended up finding [`action-slacker`](https://github.com/marketplace/actions/action-slacker).

Note: Since deciding to use this action, I've forked my own version of `action-slacker` and renamed it `slack-notifier-action`, and made a few changes for my personal usage. Those aren't anything that my readers need to pay attention to, but just know that I use personalized versions of almost all of my actions.

To use `action-slacker`/`slack-notifier-action` the way I wanted to, I needed to make two different actions: one runs on successful builds, and the other runs on failed builds. They pass in different messages and colors based on the state of the build:

```yml
{% raw %}- name: Notify Slack on Success
  if: success()
  uses: emmasax4/slack-notifier-action@emmasax4_slack_notifier_action
  env:
    # I got this from my Slack account and added it as a secret to GitHub
    SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
  with:
    channel: '#general'
    icon_url: https://i.imgur.com/DGrghtn.png
    username: GitHub Actions
    color: '#23c22e'
    title: ${{ github.repository }}
    title_link: https://github.com/${{ github.repository }}
    author_name: ${{ github.actor }}
    author_link: https://github.com/${{ github.actor }}
    author_icon: https://github.com/${{ github.actor }}.png
    text: >-
      Build <${{ env.BUILD_URL }}|${{ github.run_id }}> on branch `${{ env.BRANCH }}`
      in PR <${{ env.PULL_URL }}|#${{ env.PULL_ID }}> *passed*.

- name: Notify Slack on Failure
  if: failure()
  uses: emmasax4/slack-notifier-action@emmasax4_slack_notifier_action
  env:
    SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
  with:
    channel: '#general'
    icon_url: https://i.imgur.com/DGrghtn.png
    username: GitHub Actions
    color: '#bd2222'
    title: ${{ github.repository }}
    title_link: https://github.com/${{ github.repository }}
    author_name: ${{ github.actor }}
    author_link: https://github.com/${{ github.actor }}
    author_icon: https://github.com/${{ github.actor }}.png
    text: >-
      Build <${{ env.BUILD_URL }}|${{ github.run_id }}> on branch `${{ env.BRANCH }}`
      in PR <${{ env.PULL_URL }}|#${{ env.PULL_ID }}> *failed*.{% endraw %}
```

Ah, I almost forgot... I missed the new environment variables. By default, `BUILD_URL`, `BRANCH`, `PULL_URL`, and `PULL_ID` aren't real things. We've already seen defining `BRANCH` above. But how about the others? This is how the the rest of the `Define Variables` step looks:

```yml
{% raw %}- name: Define Variables
  run: |
    pull_id=$(echo ${{ github.ref }} | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
    echo "::set-env name=PULL_ID::$pull_id"
    echo "::set-env name=PULL_URL::$(echo https://github.com/${{ github.repository }}/pull/$pull_id)"
    echo "::set-env name=BUILD_URL::$(echo https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})"{% endraw %}
```

And that's it. Add those few steps, and now one of the slack steps will always run, depending on the rest of the build.

<div id="anchor">
  <a id="deploying-to-github-pages">&nbsp;</a>
</div>

### 3. "Deploying" to GitHub Pages

With GitHub Actions' marketplace, it made it simple to find the perfect action to "deploy" to GitHub Pages: [`Deploy to GitHub Pages`](https://github.com/marketplace/actions/deploy-to-github-pages). This action was ideal, since it didn't require me to pass a lot of environment variables or inputs in to get it working correctly. Here's what I needed:

```yml
{% raw %}- name: GitHub Pages Deploy
  uses: emmasax4/github-pages-deploy-action@emmasax4_github_pages_deploy_action
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  with:
    BRANCH: gh-pages
    FOLDER: _site
    CLEAN: true
    COMMIT_MESSAGE: 'Deploy to ${{ github.repository }}.git:gh-pages'
    GIT_CONFIG_EMAIL: 41898282+github-actions[bot]@users.noreply.github.com
    GIT_CONFIG_NAME: github-actions[bot]{% endraw %}
```

The `{% raw %}${{ secrets.GITHUB_TOKEN }}{% endraw %}` is something that's built into GitHub Actions, and is automatically provided with exactly the permissions required, so there was no passing around of permissions or tokens to obtain this.

The `CLEAN: true` was something that I added in later, when I realized that without it, deleted directories wouldn't be automatically deleted from my `gh-pages` branch. One other thing that I had to take note of was that for some reason, the deploy wouldn't work properly with `actions/checkout@v2` (it rewrites the files upon deploy, meaning each page on my site would receive a new `updated_at` or `lastModifiedAt` date upon each deploy), so I switched to `actions/checkout@v1`. Of course, `v1` of the checkout step had its own cross to bear, but that was fine for me to compromise with. I think that I could've gotten `v2` to work properly, had I finished reading the documentation for the deploy action originally.

One super cool thing that I actually suggested to the author of this action was to have a deployment status that is outputted at the end of the whole thing. It's described a bit [here](https://github.com/marketplace/actions/deploy-to-github-pages#deployment-status), but with this, I was able to custom create a Slack message specifically about the deployment:

```yml
{%raw%}- name: Set Deploy Status Message
  run: |
    if [[ ${{ env.DEPLOYMENT_STATUS }} == skipped ]]; then
      echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *skipped*)"
    elif [[ ${{ env.DEPLOYMENT_STATUS }} == success ]]; then
      echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *successful*)"
    elif [[ ${{ env.DEPLOYMENT_STATUS }} == failed ]]; then
      echo "::set-env name=DEPLOY_MESSAGE::$(echo Deploy to GitHub Pages was *unsuccessful*)"
    fi{% endraw %}
```

And then I can call that new message by using this: `{% raw %}${{ env.DEPLOY_MESSAGE }}{% endraw %}`.

Important note: when using the generic version of this action, you'll need to pass the `GITHUB_TOKEN` as a `with` variable instead of an `env` variable; I have a specific version of this action that takes it in as an `env` variable.

<div id="anchor">
  <a id="running-daily-crons">&nbsp;</a>
</div>

### 4. Running daily crons

If I'm completely honest, running daily crons is about the simplest part of this entire process. Either GitHub Actions supports crons, or it doesn't. In this case... it totally does. The [documentation for GitHub Actions schedules](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onschedule) clearly defines that we should submit our crons in UTC in Posix format:

```yml
name: Cron
on:
  schedule:
    - cron: '30 5 * * 1' # On Mondays: 05:30 UTC => 00:30 CDT / 23:30 CST
```

And that's it. The cron takes a couple of minutes longer to begin than it does with CircleCI, but that's close enough for me.

<div id="anchor">
  <a id="conclusion">&nbsp;</a>
</div>

## Conclusion

After what's probably about 8 hours of work, my new CI solution is complete. My site now completely uses GitHub Actions to build and deploy, and there's only a couple things I compromised.

1. Builds take little bit longer (maybe 30 seconds longer... still shorter than with Travis CI)
2. More lines of duplicated workflow code
3. Crons don't exactly start on the dot... they make take about 2 minutes to be triggered (still better than the 1 hour that Travis CI warned about)

But these cons are worth it, given that my site now completely runs on GitHub Actions and doesn't need any other tooling.

If somebody were to ask me whether to use GitHub Actions, Travis CI, or CircleCI, I'd give different responses based on the use case. If the person wants something supported, familiar, and common, then I'd say to use Travis CI. In an enterprise setting, Travis CI probably has some of the best abilities to connect to AWS, Heroku, Jenkins, etc. If the person wants something that's still formally supported, and potentially willing to try new things, then CircleCI may be the way to go. It's fast, simple, and relatively easy to use (if you are willing to make additional bash scripts). And if the person wants something natively built into GitHub, is okay duplicating some code, and is willing to poke around more open source code, then GitHub Actions can be a powerful tool. Also, with either Travis CI or GitHub Actions, if you don't want builds running on a few select branches, you don't need to explicitly ignore them, like with CircleCI. It's worth noting that for all three of these CI solutions, you'll have to start spending money if you want to use them heavily with private repositories.

And as for me, I think I'm going to have to cut myself off from new CI solutions for now. GitHub Actions does everything I want it to, and now that it's all set up, it's fast, easy to maintain, and of course, I've got that one big bonus... I've eliminated a third party development dependency.

---

EDIT: Since writing this blog post, I've moved my `master` branch to be called `gh-pages`, and I've updated this blog post accordingly.
