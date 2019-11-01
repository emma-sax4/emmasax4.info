---
layout: thought
title: Adding Pagination without Jekyll
tags: [ tech, jekyll ]
---

As I stated in my original [_Switching to Jekyll_](/thoughts/2019-09-09-switching-to-jekyll) post, one of the original reasons I wanted to move to a Jekyll-based site was so that I could implement pagination on my Thoughts page(s). Converting my site to Jekyll was definitely challenging, and it involved me learning a new framework and a new language (Liquid). And therefore, the <a href="https://github.com/emma-sax4/emma-sax4.github.io/pull/6" target="_blank">pull request that made the switch</a> was massive, and took a while—it had 54 changed files and 19 commits. Because of this, I decided that pagination should come in a separate pull request. And then, because I'm in my "website-phase", I thought I'd write a thought about it 🤷🏻‍♀️😂.

I originally tried to add Jekyll's built-in pagination. Supposedly, it's pretty slick. You add a few sections to the `_config.yml`, a couple sections to your `index.html`, and bam: it's done and it works 💥. My real experience setting up the pagination was _not_ like that. In fact, within one commit, I learned that Jekyll's pagination (and other pagination gems), wouldn't work well with my current directory/file setup. Both <a href="https://jekyllrb.com/docs/pagination/" target="_blank">Jekyll's built-in pagination</a> and the gem <a href="https://github.com/sverrirs/jekyll-paginate-v2" target="_blank">`jekyll-paginate-v2`</a> expect the blog posts to be in a `_posts/` directory, and to be referenced by `site.posts`. Mine are not because they're called "thoughts" (don't ask me why, I wanted to be unique). And of course, as soon as I worked to move that around, my site broke. And so, instead of fighting with that, I decided to get more creative. That can't be the only pagination option, right? 🥴😬🙏🏼

Turns out, the Google doesn't have a lot of other suggestions on pagination. But, the original Jekyll repository I copied (<a href="https://github.com/UMM-CSci/senior-seminar" target="_blank">UMM-CSci's `senior-seminar`</a>), implements a version of pagination that's installed from <a href="https://listjs.com/docs/pagination/" target="_blank">`List.js`</a>. Possibly this is because that site uses `seminars` instead of `posts`. But either way, I decided to give it a chance. Worst case scenario, it just wouldn't work and I'd have to find another pagination option.

Of course, I started with the things I know how to do best: copy-paste 💁🏻‍♀️. I started with <a href="https://github.com/UMM-CSci/senior-seminar/blob/master/seminars.html#L63-L80" target="_blank">this blob</a>, of course edited to suit my HTML file. Surprisingly, bits of this work right out of the box. But... the pagination isn't pretty, which is very important to me.

<div align="center">
  <a data-flickr-embed="true" href="https://www.flickr.com/photos/184539266@N08/48741690227/in/album-72157710863695862/" target="_blank" title="bad_pagination_bar"><img src="https://live.staticflickr.com/65535/48741690227_e27cb82884.jpg" width="450" height="367" alt="Bad pagination bar"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>
</div>

So, I went on a mission to figure out how to make a prettier pagination bar. After a couple of hours, and a good night's sleep, I realized that the answer lies in the `css/main.scss` file. Specifically, this line:
```
@import "core/index.scss";
```

Prior to adding that line, the whole Jekyll build would break. When I tried to load the project locally, my server would give me this error back:
```
".pagination .active .page" failed to
@extend ".selected". The selector ".selected"
was not found.
```
Clearly, that means my CSS is broken. But I didn't quite understand why 😕. The repository that I was copying pagination from included this line:

<div align="center">
  <a data-flickr-embed="true" href="https://www.flickr.com/photos/184539266@N08/48741503991/in/album-72157710863695862/" target="_blank" title="primer_submodule_directory"><img src="https://live.staticflickr.com/65535/48741503991_c9f4ec3ce4_o.png" width="486" height="45" alt="primer_submodule_directory"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>
</div>

Since I couldn't understand out why my CSS was broken, I figured it was time for me to try to add that "directory" to my repo.

I had never worked with submodules in Git before. So, I started how any developer-who-doesn't-recognize-anything would start: with Google. I started to google how to add submodules to Git repositories. And me, not liking to actually read anything, just started to jump in.

After everything, I ended up having to add, remove, re-add, re-remove, and re-re-add the `primer` submodule to my Git repo in order for it to commit in the repo, show up in the directory structure, and be sitting on the same commit as my example repository 🤦🏻‍♀️. Here's a list of the resources I used to help me add the `primer` submodule:
* <a href="https://chrisjean.com/git-submodules-adding-using-removing-and-updating/" target="_blank">chrisjean.com/git-submodules-adding-using-removing-and-updating</a>
* <a href="https://stackoverflow.com/questions/10914022/how-do-i-check-out-a-specific-version-of-a-submodule-using-git-submodule" target="_blank">stackoverflow.com/how-do-i-check-out-a-specific-version-of-a-submodule-using-git-submodule</a>
* <a href="https://twoguysarguing.wordpress.com/2010/11/14/tie-git-submodules-to-a-particular-commit-or-branch/" target="_blank">twoguysarguing.wordpress.com/tie-git-submodules-to-a-particular-commit-or-branch</a>
* <a href="https://subfictional.com/fun-with-git-submodules/" target="_blank">subfictional.com/fun-with-git-submodules</a>
* And possibly others I can't find in my browser history anymore

Also, note that there is no easy way to remove a submodule. I'm just glad that I attempted this inside of a pull request because then I could `git reset` when things weren't going my way.

After I finished succesfully adding the `primer` submodule 😌, all I had to do was re-add
```
@import "core/index.scss";
```
back to my `main.scss`, and finally the pagination was beautiful:

<div align="center">
  <a data-flickr-embed="true" href="https://www.flickr.com/photos/184539266@N08/48741504061/in/album-72157710863695862/" target="_blank" title="lovely_pagination_bar"><img src="https://live.staticflickr.com/65535/48741504061_7ebbd630fa.jpg" width="450" height="311" alt="Lovely pagination bar"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>
</div>

I was thrilled with the outcome of this pagination (even though it wasn't Jekyll's officially supported pagination), and I committed to master. However, perhaps a day later, I noticed something wrong with my CSS formatting. Perhaps you can notice it if you compare the before-pretty-pagination and the after-pretty-pagination pictures... I'll give you a hint: it has to do with the indentation and spacing of the words. Somehow, making the pagination bar pretty messed up my CSS formatting!

I was upset. I wanted to have both a pretty pagination bar and proper formatting of the text. So, I went back in my commit changes and commented out everything from when the site last worked as expected. I slowly uncommented line after line until I found the problem line.... of course it happened to be with the same line that makes the pagination work:
```
@import "core/index.scss";
```
Are we even surprised 😤🙄?

So, I went on a mini-adventure through the `primer` code to see what that line was doing. Apparently, it ends up installing a bunch of CSS files through other nested CSS files. Let's be real, even if I have the time to go through each one looking for what may be conflicting with my `main.scss` file, I don't want to do that. So, I did an entire repository-wide file search for: `primer/pagination/index`, found the single pagination CSS page I needed (since that's all I'm using `primer` for), and switched to import just that:
```
@import "pagination/index.scss";
```

And it turns out, the answer was as easy as that! Now, I have proper CSS layouts, a lovely pagination bar that works and doesn't take long to load, and the file structure of my project was able to stay the same. The pagination bar isn't perfect, but it's better than anything I had before, and it's good enough for me—for right now anyway.

Since the pagination part of this project is _finally_ done, I can officially say that I've now gotten everything out of Jekyll that I had hoped to, and then some. Not only did I implement a website with a "blog" that I'm proud of, but I learned a new framework and a new coding language. And most importantly, I reminded myself that one of the most important parts of being a coder is being willing to dive in, try something new, and not be afraid to fail.
