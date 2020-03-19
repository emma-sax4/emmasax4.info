---
layout: post
title: Why I Switched from Travis CI to CircleCI
tags: [ tech ]
permalink: /blog/posts/why-i-switched-from-travis-ci-to-circleci/
date: 2020-04-30 00:00:00 -0500
---

About three weeks, I started the next mini project on this website, and that was to slowly move my website's building and testing from [Travis CI](https://travis-ci.org/) to [CircleCI](https://circleci.com/). To start off, I'll walk through the reasons why I wanted to try to switch.

The initial reason why I integrated with Travis CI as my integration platform is outlined in [this blog post](/blog/posts/using-jekyll-paginate-v2/). But, as my website has continued to develop, there are four basic things I want my CI integration tool to be able to do for me:
1. Build my website using Jekyll quickly and run HTML proofer on it
2. Notify a Slack channel when the build was done
3. "Deploy" my website by making a commit back to my [`master` branch in GitHub](https://github.com/emma-sax4/emma-sax4.github.io/tree/master) (which GitHub Pages will then deploy for me)
4. Run a daily cron so that I can automate the build to run whenever I want (ideal for when I'd like to publish a blog post at a specific time, which involves having CI integration run a job at that time)

Travis CI can do all four of these things, and some of them were easier to set up than with CircleCI! I'll walk through that in a second.
