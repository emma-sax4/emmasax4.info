---
layout: post
title: Bootstrap, CSS, and Icons in this Site
tags: [ tech ]
permalink: /blog/posts/bootstrap-css-and-icons-in-this-site/
redirect_from:
  - /blog/posts/2019-12-29-bootstrap-css-and-icons-in-this-site/
date: 2019-12-29 00:00:00 -0600
---

## Bootstrap

This site uses Bootstrap for most of its CSS. I have Bootstrap to attribute to the site looking so nice. Here are the "elements" that I'm using from Bootstrap:

### Layout

My site is responsive because of [Bootstrap's responsive layout](https://getbootstrap.com/docs/4.0/layout/overview/) option! This is what determines the break-points to change the section margins and width size. I use the [Grid system](https://getbootstrap.com/docs/4.0/layout/grid/) to make the proper columns.

### Pagination

To make the pretty pagination bar appear on the blog pages, I use [Bootstrap's built-in pagination](https://getbootstrap.com/docs/4.0/components/pagination/) to create the CSS. Specifically, I use `disabled` and `active` states, as well as center-page alignment. See where I implement Bootstrap's pagination bar [here](https://github.com/emmasax4/emmasax4.info/blob/62b1cc916f71d07f5935b31ae218a0805edf56c8/_includes/blog/pagination.html#L1-L2). For the icons, I use [Feather Icons](https://github.com/feathericons/feather).

### Navbar

The responsive navbar utilized in this site is from [Bootstrap's built-in navbar](https://getbootstrap.com/docs/4.0/components/navbar/) option. Specifically, it uses the [Navbar](https://getbootstrap.com/docs/4.0/components/navbar/#nav) which is fully responsive on smaller screens, as well as the `Primary` color scheme shown [here](https://getbootstrap.com/docs/4.0/components/navbar/#color-schemes). I do add some custom icons to the drop-down section of the responsive navbar, as well as customizing the color and the font-styles. The navbar is in action [here](https://github.com/emmasax4/emmasax4.info/blob/62b1cc916f71d07f5935b31ae218a0805edf56c8/_includes/site/header.html), and [here](https://github.com/emmasax4/emmasax4.info/blob/1db304c1b1358bfc47f67783448807f173cb18a2/assets/css/_navigation.scss) is the overriding CSS for my navbar.

### Tables

For my tables on this site, I use [Bootstrap's built-in tables](https://getbootstrap.com/docs/4.0/content/tables/), which are responsive, as long as you use `class: "table-responsive"` at the top (read more about responsive tables [here](https://getbootstrap.com/docs/4.0/content/tables/#responsive-tables)). The tables I've selected to use is described in ['Hoverable Rows'](https://getbootstrap.com/docs/4.0/content/tables/#hoverable-rows). I use the tables in [this Markdown file](https://github.com/emmasax4/emmasax4.info/blob/62b1cc916f71d07f5935b31ae218a0805edf56c8/_pages/around-town.md#on-stage) and in [this Markdown file](https://github.com/emmasax4/emmasax4.info/blob/a7476415f32185b45321b04a7abf869d37e3e623/_posts/2019-12-20-dns-domains-and-personal-websites.md#domains). Because it's Markdown, it may be more helpful to view the 'Raw' code.

### Buttons

This site uses [Bootstrap's buttons](https://getbootstrap.com/docs/4.0/components/buttons/) for all of it's button functionality (unless the button is an icon). Here's a [button that I've made](https://github.com/emmasax4/emmasax4.info/blob/62b1cc916f71d07f5935b31ae218a0805edf56c8/_includes/elements/github-issue-button.html) that uses Bootstrap's design but includes a Feather Icon. I prefer the look of the [Outline buttons](https://getbootstrap.com/docs/4.0/components/buttons/#outline-buttons) more than the solid ones, but that's just my preference.

## CSS

Using Bootstrap for the entire layout of this website, as well as for specific elements means there's so much less CSS in this repository. I started with over 600 lines of CSS, and now I have about 220 lines. But, there are still some pieces that I've chosen to override from Bootstrap's defaults. All of my custom CSS is in [this directory](https://github.com/emmasax4/emmasax4.info/tree/62b1cc916f71d07f5935b31ae218a0805edf56c8/assets/css).

The pieces I'm overriding are:
* Blockquotes
* Preformatted monospace (like code snippets)
* Links and buttons
* Navbar settings and colors
* Other site settings
  * Font sizes and styles
  * Settings for the `main-content` and `body`
  * Footer

## Icons

The site uses [Feather Icons](https://feathericons.com/) for all of its pretty icons, including the
* GitHub icon
* LinkedIn icon
* Twitter icon
* Mail send icon
* Forward/backward icons
* Navbar X and bar icons
* Feed/RSS icon

Icons are called like this:
```html
<i data-feather="twitter"></i>
```

To make the icon into a button, you can write it in an `a href` tag:
```html
<a href="https://twitter.com/emma_sax4" class="link-icon">
  <i data-feather="twitter"></i>
</a>
```

The `link-icon` class is something that I've created with common link-icon settings. Read more about my custom CSS in the secton above.

Lastly, as long as these two lines are at the bottom of the file, the icons appear magically!
```html
<script src="https://unpkg.com/feather-icons"></script>
<script>feather.replace()</script>
```

See them in action [here](https://github.com/emmasax4/emmasax4.info/blob/129867d8135a930f4d364fe026db123d655b5ca8/_includes/site/scripts.html#L3-L4).

## Conclusion

Now that you've seen how Bootstrap and Feather Icons have improved my website, it's your turn! Check out my blog post [here](/blog/posts/adding-bootstrap-to-your-static-content-site/) for more information on how to get Bootstrap started on your site.
