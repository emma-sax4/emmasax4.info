---
layout: post
title: Why and How I Renamed my <header-code>master</header-code> Branch
tags: [ tech ]
permalink: /blog/posts/why-and-how-i-renamed-my-master-branch/
draft: true
---

## What

With the recent focus on the BLM movement, something that's been popping up on my Twitter radar has been renaming the default branch on our git repositories to be `main` instead of `master`. Actually, to be anything else besides `master`. Obviously, this could be a trend. This could just be a funny thing that we do that involves work, and it turns out pointless, or not having benefitted anybody. But it could also be something small that we do now, that actually makes people feel better. It could actually make a difference, and we may not even know it. If there's even a possibility of helping people, then why not do something like this? Who are we hurting by taking this action? Probably not anybody. Who _might_ we be hurting by _not_ taking this action? Possibly lots of people.

At first glance, I thought it was silly. Isn't `master` the original default branch for a reason? It's kind of industry standard, right? Yes, it is industry standard. But just because something is the standard doesn't mean it can never be reevaluated. But, as I saw more people and companies looking into doing this, I realized that maybe it wasn't as silly or as time-consuming as I thought. If companies are automating it to be done in two days, then maybe it's not as disruptive to developer workflow as I thought.

## Why

So, my research began. From [this Twitter conversation](https://twitter.com/mislav/status/1270388510684598272), it's clear that people are undecided whether it's worth it to make the switch. A lot of people are saying it's a waste of time. This [GitHub issue conversation](https://github.com/pmmmwh/react-refresh-webpack-plugin/issues/113) has people complaining that the switch has broken peoples' projects, and is not actually helping people. But from my recent experience doing the switch (which took this project maybe an hour), it's been pretty painless. I'm not sure if it'll actually help people or not, but it certainly hasn't hurt anybody yet.

For the people that say the use of `master` isn't about "master"/"slave", but more about "master's degree" or "Kung Fu master" context (apparently the word `master` is overloaded in English). However, [this blog post](https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html) has kindly pointed out that even Linus Torvalds used the word master, which came from BitKeeper's use of `master`, which actually uses the word "slave" in the same sentence with the word "master" in its documentation. So sure, maybe people nowadays don't think of the phrase `master` branch as in the "master"/"slave" context, but that's where it started. And now, for better or worse, when I see a `master` branch, that's what'll pop into my head.

## How

Okay, so now we know why I changed my repositories' default branches. For the most part, I decided to go with `main`. This is because it's environment-ambiguous, and it's short and easy. The word "main" has two whole characters less than "master", and it has the benefit that the `ma-` beginning matches the previous `master` branch. How I did the switch:

```bash
$ git branch -m master main
$ git push -u origin main
# Change default branch in GitHub repository settings page.
# Update any branch protection to protect main instead of master.
# Delete the master branch.
```

If my projects had more clones or had more collaborators, I'd certainly want to write a brief message in the README and/or try to inform them ahead of time so they could prep their repositories. After the switch, here's a suggestion for updating local clones:

```bash
$ git checkout master
$ git branch -m master main
$ git fetch
$ git branch --unset-upstream
$ git branch -u origin/main
$ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
```

I haven't touched or changed any of my repositories that are forks... I'm still undecided whether I want to change those if the upstreams don't change their default branch.

## How with GitHub Pages

The repository that manages this project had the most difficulty changing branches. GitHub Pages has this strange requirement that for GitHub user pages (which my project was, meaning the repository name ends in `.github.io`), GitHub Pages _needs_ to use the `master` branch. I actually think a change on this type of thing _could_ be coming, so I'll keep an eye out. But until then, this restriction put a damper in my plans. So, instead, my workaround was:

1. Change my repository to be a GitHub project page
2. Change the `master` branch to be `gh-pages` (it has to be either `master` or `gh-pages`)

So, because doing the branch switch on this project was more involved than other projects, I'll walk through how I completed each step, and provide the pull requests associated.

### Make my repository a project page

GitHub Pages offers three types of pages: organization, user, and project. An organization or user page requires the repository to be named as `<organization-or-user-name>.github.io`. As of right now, they use the `master` branch to read from, and the HTML/Markdown files for the page _must_ live on the `master` branch or in the `docs/` folder on the `master` branch. A project page's repository can be named whatever you'd like, and the GitHub Pages can either be read from `master` branch, `docs/` folder on `master` branch, or `gh-pages` branch.

Personally, I think these restrictions are very limiting. Hopefully, GitHub will make some changes soon so that we have more options for what branch to read GitHub Pages from, but until then, this is what we're stuck with.

So to change my user page to a project page, all I had to do was rename the repository. I did this from the repository settings page at the very top. Then, I removed my repository from my local machine and recloned it just to have a fresh copy. To my knowledge, my website continued to serve properly, even throughout the rename, because I was using my `master` branch.

### Change the <header-code>master</header-code> branch to be <header-code>gh-pages</header-code>

To do this, I followed a similar process to the above instructions for changing `master` to `main`:

```bash
$ git checkout master
$ git branch -m master gh-pages
$ git push -u origin gh-pages
# Change GitHub Pages settings to use gh-pages branch.
# Update any branch protection to protect gh-pages instead of master.
# Delete the master branch.
```

And that was it. There were a couple of minutes where GitHub Pages wouldn't update my site. To remediate this, I added a commit from the GitHub UI with a verified email, and then when that didn't seem to work (and I got an email about my custom domain already being in use), I removed and re-added my custom domain `CNAME` file. I'm not sure which action fixed my issue—or even if I needed to do anything... maybe I just should've waited. But after that hiccup, everything went smoothly from there on out, and the change was practically done.

### Pull Requests

Since this shift, I've actually made a lot of changes on GitHub. I've changed my GitHub username, changed the name of my default branch on my project from `source` to `main`, as well as normal updates and changes to the site. So, although the pull requests each look a little bit out-of-date, I'll link them all here so they can be perused for the changes I had to make as I went:

* [Renaming the repository]({{ site.github_repo }}/pull/243)
* [Renaming `master` branch]({{ site.github_repo }}/pull/244)
* [Renaming default branch]({{ site.github_repo }}/pull/245)

By the end of everything, I now have one repository (that's a project GitHub Page instead of a user page), two branches (`main` and `gh-pages`, and each name is descriptive and accurate), and a new GitHub username (that's completely unrelated).

## Final Thoughts

At the end of the day, I'm not sure renaming my `master` branches has helped anybody. Probably not (I'm the only one that looks at my source code). But so far, it hasn't hurt anybody either. And at least it shows that I'm willing to listen, and to take proactive steps to try to make things better, even if they're just baby steps or not really useful. I was willing to _try_.

The truth is that up until now, the concept of a `master` branch has never bothered me, and I don't really know if it bothers other coders of color (nobody I know has ever brought it up). But just in case, now I know that it's an easy switch to make, and there's only good that can come of the switch.

So no, I'm not going to ask _every single repository I ever work on_ be switched to use `main` instead of `master`. But I will support the switch of any repository whose owners want to do it. After all, what have we got to lose?

## References and Resources

* https://help.github.com/en/github/working-with-github-pages/about-github-pages
* https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
* https://twitter.com/mislav/status/1270388510684598272
* https://github.com/pmmmwh/react-refresh-webpack-plugin/issues/113
* https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterToMain.aspx
