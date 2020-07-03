---
layout: post
title: My First Blog Post
tags: [ tech ]
permalink: /blog/posts/my-first-blog-post/
redirect_from:
  - /blog/posts/2019-09-06-my-first-blog-post/
date: 2019-09-06 00:00:00 -0500
---

I've been wanting to start a blog for myself for a while, but I've been having trouble figuring out where to start. But, there's no time like the present, so I thought I might as well just go for it!

The very first blog I started, used Ruby On Rails... you can check it out [here](https://github.com/emmasax4/blog). Needless to say, it didn't go very well.

But since I started to beef up this little website (which, 🤫, is actually just a bunch of static HTML files), I decided that I could probably just add the blog functionality to this site.

I originally wanted to try to use layouts, Jekyll, and javascript-like styles to store the blogs as Markdown files. In that case, the main "Blog" page would just use a fancy little loop to show each of the blog posts. But that turned out to be more difficult than I thought it would be. In all honesty, I could figure it all out myself... there's plenty of examples out there in GitHub. But I had a limited amount of time I wanted to spend putting the blog together, and tbh, I had a limited amount of patience as well.

Instead, I figured... I'm afraid of neither a little bit of HTML nor a little bit of duplicated code (I know the code isn't as "pretty," and if there was actual functionality on this website, I would try harder to avoid it). So, I realized that I could make a decently good blog function by simply being smart about my HTML, CSS, and `href` linking. At the very least, it would look professional, and like I knew what I was doing, even if the skeleton of the code is a little ugly.

Then, I went a step further. I added a `.htaccess` file (even though GitHub Pages normally doesn't play nice with that file), so that the URLs of this website could hide the `.html` endings of the HTML pages. In this way, the website wouldn't show up as obviously just a compilation of HTML files... aka it makes it look like the whole website is served using RoR or something like that. And then, using a little bit of directory-magic, I can add a bunch of posts in a `_posts/` directory — and link to them appropriately. Add in a `Back` button, and voilà... here we are!

Now I have a blog feature that I can edit as I choose (as long as I'm willing to duplicate my code). I'm excited to add my next blog post to the list. Let's see how long it takes for this blog to stop being updated... it may just be a phase.

** It's come to my attention that there are a few aspects of a _blog_ that this doesn't include. Mainly, the ability to comment, converse with others, and have notes regarding each blog post.
