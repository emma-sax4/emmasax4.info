---
layout: thought
title: Adding Pagination without Jekyll
tags: [ all, tech, jekyll ]
draft: true
---

As I stated in my original _[Switching to Jekyll](/thoughts/all/2019-09-09-switching-to-jekyll)_ post, one of the original reasons I wanted to move to a Jekyll-based site was so that I could implement pagination on my Thoughts page(s). Switching to Jekyll was definitely challenging, and it involved me learning a new framework, and essentially even a new language (liquid). And therefore, the [pull request that made the switch](https://github.com/emma-sax4/emma-sax4.github.io/pull/6) was massive, and took a while—it had 54 changed files and 19 commits. Because of this, I decided that pagination should come in a separate pull request. And then, because I'm in my "website-phase", I thought I'd write a thought about it 🤷🏻‍♀️😂.

I originally tried to add Jekyll's built-in pagination. Supposedly, it's pretty miraculous. You add a few sections to the `_config.yml`, a couple sections to your `index.html`, and bam: it's done and it works 💥. My real experience setting up the pagination was _not_ like that. In fact, within one commit, I learned that Jekyll's pagination (and other pagination gems), wouldn't work well with my current directory/file setup. Both [Jekyll's built-in pagination](https://jekyllrb.com/docs/pagination/) and the gem [`jekyll-paginate-v2`](https://github.com/sverrirs/jekyll-paginate-v2) expect the blog posts to be in a `_posts/` directory, and to be referenced by `site.posts`. Mine are not, because they're called "Thoughts" (don't ask me why, I guess I wanted to be unique). And of course, as soon as I worked to move that around, my site broke. And so, instead of fighting with that, I decided to get more creative. That can't be the only pagination option, right? 🥴😬🙏🏼

Turns out, the Google doesn't have a lot of other suggestions on pagination. But, the original Jekyll repository I copied ([UMM-CSci's `senior-seminar`](https://github.com/UMM-CSci/senior-seminar)), implemented a version of pagination that's installed from [`List.js`](https://listjs.com/docs/pagination/). Possibly that's because that site uses `seminars` instead of posts. But either way, I decided to give it a chance. Worst case scenario, it just wouldn't work and I'd have to find another pagination option.

Of course, I started with the things I know how to do best: copy-paste 💁🏻‍♀️. I started with [this blob](https://github.com/UMM-CSci/senior-seminar/blob/master/seminars.html#L63-L80), of course edited to fit my HTML file. Surprisingly, bits of this work right out of the box. But... the pagination isn't pretty, which is very important to me.

<div align="center">
  <img src="/resources/pictures/thoughts/bad_pagination_bar.png" alt="Badly formatted pagination bar">
</div>

So, I went on a mission to figure out how to make a prettier pagination bar. After a couple of hours—and a good night's sleep—I realized that the answer lies in the `css/main.scss` file. Specifically, [this line](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/css/main.scss#L3).
