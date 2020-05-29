---
layout: post
title: Switching to Jekyll
tags: [ tech, jekyll ]
permalink: /blog/posts/switching-to-jekyll/
redirect_from:
  - /blog/posts/2019-09-09-switching-to-jekyll/
date: 2019-09-09 00:00:00 -0500
---

A few days ago, I published another blog post (read it [here](/blog/posts/my-first-blog-post/)), in which I stated that although I wanted to originally try to use Jekyll more, I gave up, instead favoring raw HTML files, hard-coding the headers and links.

After reflecting on this decision (after publishing that post of course), I changed my mind. I don't want to consider myself a giver-upper, and I certainly don't want to shy away from learning new coding frameworks, all because I don't want to spend a few more hours in front of the computer 💻. In fact, in the long run, utilizing Jekyll on this site will actually _save_ me time (and code) as I continue to add more posts and content to the site. However, if I'm completely honest, the biggest thing that made me want to switch to Jekyll was the ugly pagination that would have to be hard-coded and change frequently as more posts were added to the site. By switching to be Jekyll-based, this could be avoided.

So, the first thing I did, after making this decision, was to find an example repository that used Jekyll, so I could copy off of it. I ended up selecting [UMM-CSci's `senior-seminar`](https://github.com/UMM-CSci/senior-seminar), which I had made a few other pull requests for during and right after college. I choose this because I had seen the code before, even if I never took the time to look at it in detail, and I knew (or once knew) the main contributors to the repository. I also vaguely remember the switch from raw HTML and Markdown files to Jekyll-based, which took place in [this pull request](https://github.com/UMM-CSci/senior-seminar/pull/9), even if I didn't work on it myself. That pull request is hard to parse... it has 355 changed files, no comments, and only vague descriptions. For my switch, I didn't actually look at that PR, although I could've if I had wanted to 💁🏻‍♀️.

One of my flaws when I code is that I'm not always a big fan of thinking and reading... I like to just jump in and start coding, especially if I'm working on my own project. So I skipped all of the official Jekyll documentation (I've looked at it since when googling, but I didn't start there), and I started copying files. I began with the `_includes/` directory, AKA the first directory GitHub shows in the root directory. And I kept copying the basic files, making small changes to my copies, as necessary.

Before long, I had a working homepage, with a single item in the header ("Home"), and my pictures showed up. As I started adding more pages, I got more understanding of the purpose of each directory, and how the Markdown files and HTML files worked together. By the time I moved onto the most complicated page, the "Blog" page, I had a decent understanding of the basics of Jekyll.

But it wasn't until I started working on the "Blog" page that I got to play around with collections, loops, `if`s, etc. My first goal was to make the list of posts all show up as they were supposed to, with the proper title(s) and dates. It turns out Jekyll makes this pretty easy. This sweet line gathers all of the blog posts on the site:
```
{% raw %}{{ site.posts }}{% endraw %}
```

And you can loop through them like this:
```
{% raw %}{% for post in site.posts %}
  {{ post.title }}
{% endfor %}{% endraw %}
```

Then I wanted to add appropriate buttons to go back to the whole list of posts, and to the more general collections of posts, if there were any posts that were intentionally grouped together. This would also be the start of adding tags to the posts in order to organize them together, beyond just the titles. With this, I had to categorize each post, figure out how to compare the tags, and filter the posts based on the tags assigned. The easiest answer I found was to add a single `tag` to each main posts list, which would eventually be the tag to show on that page. Then, have each post have a list of `tags`. And any post that includes that single `tag` would appear on that list 💡. It only took me about 3️⃣ hours to come up with that.

The latest addition to the posts collection was to utilize [Jekyll's draft](https://jekyllrb.com/docs/posts/#drafts) capability. I wanted an easy way to make draft posts, where I could work on them, and leave them until I was ready to publish them. I'm fully aware that even drafts aren't fully private; drafts are stored as Markdown files on GitHub in a public repository, so anyone could see an unpublished draft by just viewing it on GitHub. But, using the built-in draft capability would make it easier for people that only view the website, not in GitHub.

And then also, there's a `show_drafts: false` line to add to the `_config.yml`, which all of the official documentation fails to mention. They talk about running the local server with the `--drafts` flag, but don't talk about changing the config file. So, it took me quite a bit of googling until I could fit together all of those puzzle pieces 🧩.

Hours of work later—I'm writing this Sunday night, and I started switching to Jekyll on Friday—I finally have a Jekyll-based site that's hosted fully on GitHub Pages. I stayed up until 2am Friday night, and 5am Saturday night, prepping this. The main before-and-after content pages look _super_ similar, which is the point. The biggest difference is the "Blog" page, which is now set up for success in the future, even if it isn't too different right now.

I still have work to do with Jekyll. I haven't finished setting up my paginated "Blog" pages yet. After that's done, I'll start working on filtering the posts by tags, which also Jekyll supports. But the main point is that, the only way I could fully learn Jekyll, and feel more confident with it, is by jumping in, and using it. And, by using Jekyll to help you compile your site, you can avoid typing long blog posts and content pages with HTML... it's so much easier to get in the writing zone in Markdown 🙌🏼!
