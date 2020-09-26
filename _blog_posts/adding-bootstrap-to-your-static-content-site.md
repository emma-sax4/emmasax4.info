---
layout: post
title: Adding Bootstrap to Your Static Content Site
tags: [ tech ]
permalink: /blog/posts/adding-bootstrap-to-your-static-content-site/
date: 2019-12-17 00:00:00 -0600
---

Between when I originally turned this website into a Jekyll site and a couple of weeks ago, a decent amount of CSS in the site had been slowly changing. First of all, the navigation bar had gone from a whole quarter of the screen to just a small top bar. The navigation words had moved to the right of the screen. But most importantly, I was attempting to make the site responsive to different screen widths (particularly mobile vs. computer). And there was a point when I realized that there were certain limitations my CSS/HTML knowledge had.

Although it is arguably beneficial for a coder like me (that's young in my career) to hand-craft all of my site's CSS, the truth is that the site won't come out as nicely as if I use a 3rd party tool. And, one could even claim that getting experience in implementing a 3rd party tool, and figuring out the best ways to use it, is even better experience.

So, let's walk through the process of adding Bootstrap to a Jekyll site, since this is what I did _very_ recently.

---

## Install Bootstrap into your site

I selected to use the most recent version of Bootstrap (4.4), and wanted to install it via a `<script>` and CDN. If you put this line right before where your site links your own stylesheets, then it'll automatically import this and combine the two CSS's:

```html
<link
  rel="stylesheet"
  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
  crossorigin="anonymous"
>
```

Your site will take all of Bootstrap's CSS, and then consider whatever you've coded as overrides.

## Load your site locally and see what breaks 🤷🏻‍♀️

When I first loaded my site, a surprising amount of the site successfully showed up. In fact, I'd even say that it pretty much looked exactly like what it was before, because my local CSS was overriding all of Bootstrap's CSS. The only big thing that changed was my font styles. At the end of the day, I chose to keep Bootstrap's styles anyway because I started to get used to the new font.

If your site does start to break, then that's an indicator that there's probably some of your custom CSS that you should get rid of. If you're going to use Bootstrap, you might as well _use_ Bootstrap, which includes using most of Bootstrap's functionality and features.

## Go through your CSS bit by bit and delete those bits

To do this part, I started with the biggest single element I could find: my navbar. I started by taking a look at [Bootstrap's built-in navbar](https://getbootstrap.com/docs/4.0/components/navbar/), and worked my way through my particular HTML file implementing a basic version of Bootstrap's navbar. This involved changing the `class` names and moving around the lines of Jekyll code that write the menu on the top. I didn't care if it was responsive or not; I could get to that later.

After I implemented the basics of the navbar, it worked pretty miraculously. It also turned out to basically be responsive right away, all I had to do was modify a few more `class` names. Then, it was time to make the navbar look like mine (with similar colors, sizing, etc).

I did an `Inspect element` on Bootstrap's website to see what I should name the CSS class in my own repo: `nav.navbar`. Then, I simply copied over my color scheme:

```scss
nav.navbar {
  background-color: rgb(27, 14, 172);
  background: linear-gradient(to right, rgb(27, 14, 172), rgb(107, 208, 245));
}
```

Then, right away I could delete all of the old navbar CSS code! This included a solid chunk of lines!

Next, I wanted to make it so the menu button (also known as a hamburger 🍔 icon) would turn into an ❌ button when the navbar expanded. This took more time, and to be honest, if not for @brianMitchL's help, I may still be struggling. In order to save you from struggling, I'll give you some code:

```scss
nav.navbar {
  > .navbar-toggler {
    // The toggle button
  }

  .navbar-toggler[aria-expanded="false"] > .x {
    // ❌ icon
    display: none;
  }

  .navbar-toggler[aria-expanded="true"] > .menu {
    // 🍔 icon
    display: none;
  }
}
```

Now, with only 20 minutes of work, I have a fully-functioning navbar that fits Accessibility standards, too!

After the navbar, I tackled [Boostrap's buttons](https://getbootstrap.com/docs/4.0/components/buttons/), [general page layouts](https://getbootstrap.com/docs/4.0/layout/overview/), and [columns](https://getbootstrap.com/docs/4.0/layout/grid/).

To do the buttons, you can go through the same process as with the navbar:

1. Look up the basic Bootstrap button's HTML
2. Make your button(s) have the same `class` names
3. Once the button looks like Bootstrap's then make small tweaks to Bootstrap's CSS class(es) to make it format like how you want it
4. Delete your button CSS

Same process with the columns. To do the page layouts and responsive breakpoints, the only piece of knowledge that I didn't know (until Brian came along), was that Bootstrap's automatically going to expect:

```html
<body>
  <main class="container">

  </main>
</body>
```

Previously, I was running that second line without the `class="container"`. But, once we added that, suddenly the entire site's body was fully responsive! Now, everything word-wrapped appropriately from a huge screen, right down to 320px wide (the size of an iPhone 5/SE). It's brilliant!

Over the next couple days, I eventually completely switched to using [Bootstrap's tables](https://getbootstrap.com/docs/4.0/content/tables/) and [Bootstrap's pagination](https://getbootstrap.com/docs/4.0/components/pagination/) (but I'll get to that in another blog post).

At the end of the day (or a few days), my repo ended up going from over 650 lines of CSS code to 185 lines. That means I cut out at least 72% of my existing CSS code. _And_ I have a better-looking, more responsive, more modern, and accessible website? It's a win-win.

---

Thank you so much for getting to the bottom of that rather technical blog post. I hope it's enough compelling evidence to remember that using a 3rd party tool to make your website's CSS better is worth it. If I (a back-end coder with very little CSS experience) can make it happen, then so can you 😉.

For more information about how my site uses Bootstrap, please see [this blog post](/blog/posts/bootstrap-css-and-icons-in-this-site/). To learn more about Bootstrap, please read their documentation [here](https://getbootstrap.com/docs/4.4/getting-started/introduction/).
