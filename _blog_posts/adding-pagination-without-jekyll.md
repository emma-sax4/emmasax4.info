---
layout: post
title: Adding Pagination without Jekyll
tags: [ tech, jekyll ]
permalink: /blog/posts/adding-pagination-without-jekyll/
redirect_from:
  - /blog/posts/2019-09-12-adding-pagination-without-jekyll/
date: 2019-09-12 00:00:00 -0500
---

As I stated in my original [_Switching to Jekyll_](/blog/posts/switching-to-jekyll/) post, one of the original reasons I wanted to move to a Jekyll-based site was so that I could implement pagination on my "Blog" page(s). Converting my site to Jekyll was definitely challenging, and it involved me learning a new framework and a new language (Liquid). And therefore, the [pull request that made the switch]({{ site.github_repo }}/pull/6) was massive, and took a while—it had 54 changed files and 19 commits. Because of this, I decided that pagination should come in a separate pull request. And then, because I'm in my "website-phase," I thought I'd write a blog post about it 🤷🏻‍♀️😂.

I originally tried to add Jekyll's built-in pagination. Supposedly, it's pretty slick. You add a few sections to the `_config.yml`, a couple sections to your `index.html`, and bam: it's done and it works 💥. My real experience setting up the pagination was _not_ like that. In fact, within one commit, I learned that Jekyll's pagination (and other pagination gems), wouldn't work well with my current directory/file setup. Both [Jekyll's built-in pagination](https://jekyllrb.com/docs/pagination/) and the gem [`jekyll-paginate-v2`](https://github.com/sverrirs/jekyll-paginate-v2) expect the blog posts to be in a `_posts/` directory, and to be referenced by `site.posts`. They also expect the main "Blog" page to be in its own directory, and my stuff wasn't formatted like that. And so, instead of fighting with that, I decided to get more creative. That can't be the only pagination option, right? 🥴😬🙏🏼

Turns out, the Google doesn't have a lot of other suggestions on pagination. But, the original Jekyll repository I copied ([UMM-CSci's `senior-seminar`](https://github.com/UMM-CSci/senior-seminar)), implements a version of pagination that's installed from [`List.js`](https://listjs.com/docs/pagination/). Possibly this is because that site uses `seminars` instead of `posts`. But either way, I decided to give it a chance. Worst case scenario, it just wouldn't work and I'd have to find another pagination option.

Of course, I started with the things I know how to do best: copy-paste 💁🏻‍♀️. I started with [this blob](https://github.com/UMM-CSci/senior-seminar/blob/master/seminars.html#L63-L80), of course edited to suit my HTML file. Surprisingly, bits of this work right out of the box. But... the pagination isn't pretty, which is very important to me.

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/48741690227_e27cb82884.jpg"
      photo_width="450" thumb_width="400" title="Ugly vertical pagination bar" lightbox="Pagination"
  %}
</div>

So, I went on a mission to figure out how to make a prettier pagination bar. After a couple of hours, and a good night's sleep, I realized that the answer lies in the `css/main.scss` file. Specifically, this line:

```css
@import "core/index.scss";
```

Prior to adding that line, the whole Jekyll build would break. When I tried to load the project locally, my server would give me this error back:

```css
".pagination .active .page" failed to
@extend ".selected". The selector ".selected"
was not found.
```

Clearly, that means my CSS is broken. But I didn't quite understand why 😕. The repository that I was copying pagination from included this line:

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/48741503991_ac5c550274.jpg"
      photo_width="486" thumb_width="450" title="Primer as a submodule" lightbox="Pagination"
  %}
</div>

Since I couldn't understand out why my CSS was broken, I figured it was time for me to try to add that "directory" to my repo.

I had never worked with submodules in Git before. So, I started how any developer-who-doesn't-recognize-anything would start: with Google. I started to google how to add submodules to Git repositories. And me, not liking to actually read anything, just started to jump in.

After everything, I ended up having to add, remove, re-add, re-remove, and re-re-add the `primer` submodule to my Git repo in order for it to commit in the repo, show up in the directory structure, and be sitting on the same commit as my example repository 🤦🏻‍♀️. Here's a list of the resources I used to help me add the `primer` submodule:

* [chrisjean.com: git submodules adding, using, removing, and updating](https://chrisjean.com/git-submodules-adding-using-removing-and-updating/)
* [stackoverflow.com: how do I check out a specific version of a submodule using git submodule](https://stackoverflow.com/questions/10914022/how-do-i-check-out-a-specific-version-of-a-submodule-using-git-submodule)
* [2guysarguing.wordpress.com: tie git submodules to a particular commit or branch](https://twoguysarguing.wordpress.com/2010/11/14/tie-git-submodules-to-a-particular-commit-or-branch/)
* [subfictional.com: fun with git submodules](https://subfictional.com/fun-with-git-submodules/)
* And possibly others I can't find in my browser history anymore

Also, note that there is no easy way to remove a submodule. I'm just glad that I attempted this inside of a pull request because then I could `git reset` when things weren't going my way.

After I finished succesfully adding the `primer` submodule 😌, all I had to do was re-add

```css
@import "core/index.scss";
```

back to my `main.scss`, and finally the pagination was beautiful:

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/48741504061_7ebbd630fa.jpg"
      photo_width="450" thumb_width="400" title="Pagination bar that's much better" lightbox="Pagination"
  %}
</div>

I was thrilled with the outcome of this pagination (even though it wasn't Jekyll's officially supported pagination), and I committed to `gh-pages`. However, perhaps a day later, I noticed something wrong with my CSS formatting. Perhaps you can notice it if you compare the before-pretty-pagination and the after-pretty-pagination pictures... I'll give you a hint: it has to do with the indentation and spacing of the words. Somehow, making the pagination bar pretty messed up my CSS formatting!

I was upset. I wanted to have both a pretty pagination bar and proper formatting of the text. So, I went back in my commit changes and commented out everything from when the site last worked as expected. I slowly uncommented line after line until I found the problem line... of course it happened to be with the same line that makes the pagination work:

```css
@import "core/index.scss";
```

Are we even surprised 😤🙄?

So, I went on a mini-adventure through the `primer` code to see what that line was doing. Apparently, it ends up installing a bunch of CSS files through other nested CSS files. Let's be real, even if I have the time to go through each one looking for what may be conflicting with my `main.scss` file, I don't want to do that. So, I did an entire repository-wide file search for: `primer/pagination/index`, found the single pagination CSS page I needed (since that's all I'm using `primer` for), and switched to import just that:

```css
@import "pagination/index.scss";
```

And it turns out, the answer was as easy as that! Now, I have proper CSS layouts, a lovely pagination bar that works and doesn't take long to load, and the file structure of my project was able to stay the same. The pagination bar isn't perfect, but it's better than anything I had before, and it's good enough for me—for right now anyway.

Since the pagination part of this project is _finally_ done, I can officially say that I've now gotten everything out of Jekyll that I had hoped to, and then some. Not only did I implement a website with a "blog" that I'm proud of, but I learned a new framework and a new coding language. And most importantly, I reminded myself that one of the most important parts of being a coder is being willing to dive in, try something new, and not be afraid to fail.

---

EDIT: Since writing this blog post, I've moved my `master` branch to be called `gh-pages`, and I've updated this blog post accordingly.
