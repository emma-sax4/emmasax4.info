---
layout: post
title: Why I Switched from CircleCI to GitHub Actions
tags: [ tech ]
permalink: /blog/posts/why-i-switched-from-circleci-to-github-actions/
date: 2020-05-30 12:51:00 -0500
---

A couple of months ago, I made a decision to explore [CircleCI](https://circleci.com/) as a continuous integration (CI) platform. After my exploration, I decided to fully switch over my website from [Travis CI](https://travis-ci.org/) to CircleCI. I wrote a blog post about _why_ I switched [here](/blog/posts/why-i-switched-from-travis-ci-to-circleci/). But two months later, although I was still content overall, something happened that made me think about cutting back on dependencies for my site.

I know my website was still dependent on a lot of content delivery networks (CDN): [GitHub Pages](https://pages.github.com/) to serve my site, [CircleCI](https://circleci.com/) to build and deploy my site, [Bootstrap4](https://getbootstrap.com/docs/4.4/getting-started/introduction/) for its buttons and CSS, [Feather](https://feathericons.com/) for its beautiful icons, [Jquery](https://jquery.com/) for its javascript responsive CSS, etc. So, I made a plan to remove all of those dependencies (crazy, right?!).
