---
layout: post
title: Adding Bootstrap to Your Jekyll Site
tags: [ jekyll, tech ]
draft: true
---

Between when I originally turned this website into a Jekyll site and a couple of weeks ago, a decent amount of CSS in the site had been slowly changing. First of all, the navigation bar had gone from a whole quarter of the screen to just a small top bar. The navigation words had moved to the right of the screen. But most importantly, I was playing with attempting to make the site responsive to different screen widths (particularly mobile vs. computer). And there was a point when I realized that there were certain limitations my CSS/HTML knowledge had.

Although it is arguably beneficial for a coder like me (that's young in my career) to hand-create all of my site's CSS, the truth is that the site won't come out as nicely as if I use a 3rd party tool. And, one could even argue back that getting experience in implementing a 3rd party tool, and figuring out the best ways to use it is even better experience.

So, let's walk through the process of adding Bootstrap to a Jekyll site, since this is what I did _very_ recently.

---

## Install Bootstrap into your site

I selected to use the most recent version of Bootstrap (4.4), and wanted to install it via a `<script>` and CDN. If you put this line right before where your site links your own stylesheets, then it'll automatically import this and combine the two CSS's:
```
<link
  rel="stylesheet"
  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
  crossorigin="anonymous"
>
```
