# Structure of this Project

### Table of Contents
- [Directory/File Structure](#directoryfile-structure)
- [Collections, categories, and tags. Oh my!](#collections-categories-and-tags-oh-my)
- [`_includes/`](#_includes)
- [`_layouts/`](#_layouts)
- [`_pages/`](#_pages)
- [`_pages/blog/`](#_pagesblog)
- [`_posts/`](#_posts)
  * [Posts with and without Tags](#posts-with-and-without-tags)
  * [Posts in a Collection](#posts-in-a-collection)
  * [Writing Drafts](#writing-drafts)
- [`assets/`](#assets)
- [`_config.yml`](#_configyml)
- [`feed.xml`](#feedxml)
- [`Gemfile` and `Gemfile.lock`](#gemfile-and-gemfilelock)
- [`index.md`](#indexmd)

## Directory/File Structure

Here are all of the parts of this project associated with running this application. This list does not include files/directories related to GitHub, Travis CI, and Git.
```
.
├── _includes
|   ├── elements
|   |   ├── button_one.html
|   |   └── button_two.html
|   ├── other
|   |   ├── pagination.html
|   |   └── sidebar.html
|   ├── site
|   |   ├── footer.html
|   └── └── header.html
├── _layouts
|   ├── default.html
|   ├── layout-01.html
|   └── layout-02.html
├── _pages
|   ├── blog
|   |   ├── category_one.md
|   |   ├── category_two.md
|   |   ├── tag1.md
|   |   └── tag2.md
|   ├── page-01.md
|   ├── page-02.md
|   └── page-03.md
├── _posts
|   ├── category-one
|   |   ├── 2001-01-01-post-a.md
|   |   └── 2001-01-02-post-b.md
|   ├── category-two
|   |   ├── 2003-01-01-post-a.md
|   |   └── 2004-01-02-post-b.md
|   ├── 2001-01-03-post-a.md
|   └── 2001-01-04-post-b.md
├── assets
|   ├── css
|   |   ├── css_file_01.scss
|   |   ├── css_file_02.scss
|   |   └── style.scss
|   ├── images
|   |   ├── picture-01.jpg
|   |   ├── picture-02.jpg
|   |   ├── picture-03.png
|   |   └── picture-04.jpg
|   ├── resources
|   |   ├── resource-01.pdf
|   └── └── resource-02.pdf
├── _config.yml
├── feed.xml
├── Gemfile
├── Gemfile.lock
└── index.md
```

## Collections, categories, and tags. Oh my!

Please notice that in the code, we need to call a collection of related posts a `category`. This is in order to make the pagination work as expected. A user of the site will view the collection no differently than with a tag. The biggest difference between a `tag` and a `category` is that a post can have multiple tags, but can only be a part of one `category`. Currently, the code is not set up to handle posts that are part of a collection _and_ contain tags.


## `_includes/`

HTML files in this directory are for page elements, such as buttons, icons, images. It is also for divs that are long or have Jekyll/Liquid logic. Each div or element should have its own file in the appropriate directory. By placing these elements here, they can be reused on multiple pages without duplicating code, and they reduce the clutter in busier pages. To call one of the elements, simply include the file in any other Markdown/HTML file:
```markdown
{% include site/header.html %}
```

## `_layouts/`

HTML files in this directory are for the skeletons of a specific page. The `default.html` is the plainest of the plain. It includes the head, header, footer, and necessary scripts, and defines the body and main content of the page. The other HTML files in the directory are for more detailed pages, such as the home page and blogs page. To specify that a certain page should use a specific layout, write that as the `layout` in the top of any other Markdown/HTML file:
```yml
---
layout: layout-01
.
.
.
---
```

Layout files should be short (20 lines at the longest) and should not contain any Jekyll/Liquid logic.

## `_pages/`

These are the general pages in the top navigation bar of the site, and they're for the main content of the site. They're written in Markdown, but Jekyll and Liquid will use the Markdown content to make HTML files. The front matter of any Markdown/HTML file specifies the settings of the page:
```yml
---
layout: page # the layout HTML to use (required for almost every page)
title: Page 01 # the title of this page (optional if the page is NOT in the nav bar)
order: 3 # the order of this page in the navigation bar (delete if the page is NOT in the nav bar)
permalink: /page-01/ # the static link this page should have (required for EACH page in this directory)
---
```

You can also specify custom settings that you want the page to have:
```yml
---
custom_field_1: true
custom_field_2: useful_string
---
```

Then, you can reference those custom settings on other HTML files (such as the layout the page is using... 😉):
```
{{ page.custom_field_1 }}
=> true
{{ page.custom_field_2 }}
=> useful_string
```

### `_pages/blog/`

This site uses [`jekyll-paginate-v2`](https://github.com/sverrirs/jekyll-paginate-v2/) to do it's pagination of the blog posts.

The first index blog page we paginate is `_pages/blog.md`. The front matter of this file is sort of repetitive, but by specifying titles and URLs, we are able to have more flexibility with our directory structure.

In addition to that page, we also paginate the `tag` and `category` filtered pages. We specify these blog pages in its own directory, titled `_pages/blog/`, where each `tag` and `category` needs to have its own page. A `tag` should be one word, and should not require camelcase or capitalization, ex: `"tag1"` or `"tag"`. An example would be `_pages/blog/tag1.md`.

For a tag, the front matter should look like this:
```yml
---
layout: blog
permalink: /blog/tag1/
pagination:
  enabled: true
  collection: posts
  permalink: /:num/
  title: Tag1
  tag: tag1
---
```

A `category` _can_ be multiple words, and can require capitalization like a title, ex: `"Category One"` or `"Category Two"`. For a `category`, the front matter should look like this:
```markdown
---
layout: blog
permalink: /blog/category-one/
pagination:
  enabled: true
  collection: posts
  permalink: /:num/
  title: Category One
  category: Category One
---

Some words describing this collection should go here.
```

## `_posts/`

These are all of blog posts I've written.

### Posts with and without Tags

Most of the posts can just go into the general `_posts/` directory, written as Markdown files. For a generic post, the front matter could look like this:
```yml
---
layout: post
title: Post A
tags: [ tag1, tag2 ] # optional
permalink: /blog/posts/post-a
date: 2001-12-14 00:00:00 -06:00 # 2001-12-14 06:00:00 UTC
---
```

The tags determine how we want to categorize each post. If there's no categorization of a post (if it's completely random), then there's no need to specify any tag(s), AKA just leave the line completely out of the front matter. But, if you think the post is a good contestant for a tag, such as `tag1` or `tag2` in our example, then add those appropriate tags in a list format, as shown above.

Without the `permalink` link in the front matter, the URL will most likely default to including the publishing date. This is not ideal, so instead, we'll set a custom permalink for each blog post.

The `date` front matter indicates the published date and time. Usually, it's totally fine with blog posts being published at midnight (usually in America/Central time zone, because that's where Minnesota is). On rare occasions when two posts are published on the same date, it's important to specify a time so they sort properly. The entire site will show in a readers' local time, but the data will be stored in the system (and will be reflected in the `feed.xml` and `sitemap.xml`) in UTC. From a human's perspective, we want time zones to be a non-issue, so we can write our date/time as the author is seeing it within the post. For Jekyll to properly interpret it, we must specify the author's current hour offset from UTC at the time of publishing.

### Posts in a Collection

If I'm going to write a collection of posts that all have a common theme, they can each go into a new nested directory: `_posts/category-one/`, and should make use of the `title` and `subtitle` metadata, where the `title` is the name of the collection, and the `subtitle` is the title of that specific post:
```yml
---
layout: post
title: Category One
subtitle: Post A
category: Category One
permalink: /blog/posts/category-one/post-a
date: 2001-06-27 20:30:00 -05:00 # 2001-06-28 01:30:00 UTC
---
```

### Writing Drafts

To write drafts, make a new file in the `_posts/` directory (or in a subdirectory if the post will be part of a category). The new file should be named in the following pattern: `YYYY-MM-DD-test-post-title`. Because this draft hasn't been published yet, I usually just put in the date I hope to publish the draft (usually a few days in the future).

To the front matter, make sure to add the `layout`, `title`, and `permalink` (`subtitle`, `category`, and `tags` are all optional).

Then, when you run `jekyll serve --future` locally, the draft post(s) should appear at the top of the list of posts, and should show as "Unpublished."

When it's time to publish the post, you can either:
* Publish the post now:
  * Add the current date/time (in the author's local time zone, properly identifying the current hour offset from UTC) to the post's front matter in the `date` value
  * Rename the file to have the current date instead of whatever was there previously
  * Re-add and commit those files to the pull request
  * Merge the pull request into the `release` branch
* Publish the post on a future date:
  * Add the future publishing date/time (typically 00:00:00 in the author's local time zone, properly identifying current the hour offset from UTC) to the post's front matter in the `date` value
  * Rename the file to have the publishing date in the title instead of whatever was there previously
  * Merge your pull request into the `release` branch
  * Wait until Travis CI builds the newest version around midnight in CST on the day of publishing (or rerun the latest `release` build [here](https://travis-ci.com/emma-sax4/emma-sax4.github.io/builds) on the day of publishing)

To identify the current hour offset from UTC, look up the time zone offset based on your location [here](https://www.timeanddate.com/time/zone/).

## `assets/`

This directory has three directories, `css/`, `images/`, and `resources/`. The `css/` directory contains all of the CSS files in this site. They're all called together in `style.scss`. The CSS in the project is loaded inside the `_includes/head.html`. This site also uses [Bootstrap](https://getbootstrap.com/docs/4.4/getting-started/introduction/) for a lot of its CSS, including the navigation bar, headers, responsive page, etc.

The `images/` directory gives me a place to store all of the images this site uses. To call a specific image, you can either ask for it in HTML:
```html
<div>
  <img class="my-image" src="/assets/images/picture-01.jpg" alt="Picture 1">
</div>
```

The `resources/` directory gives me a place to keep PDF documents that are linked in this site. You can put a link to it in Markdown:
```markdown
This is an example sentence, so it will throw a 404. See [here](/assets/resources/resource-01.pdf)?
```
When calling internal resources like this, it'll automatically open in the same tab that the user is currently in. If you wish to open it in a new tab, you'll have to specify that:
```markdown
This is an example sentence, so it will throw a 404. See <a href="/assets/resources/resource-01.pdf" target="_blank">here</a>?
```

## `_config.yml`

This is where we tell Jekyll all of the configurations for this project. Each time this file is changed, restart your local Jekyll server to get the new changes.

## `feed.xml`

This site implements a basic RSS feed for subscribers to keep an eye on the blog posts on this site. This file automatically updates whenever Travis CI will build on the `release` branch builds. A subscriber should use a feed reader to watch the feed.

## `Gemfile` and `Gemfile.lock`

The Gemfile is where the application defines which Ruby gems are important to run the application. To learn how to use these files, see this [section](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/.github/CONTRIBUTING.md#running-locally).

## `index.md`

This is the first page that the site sees. Because of the way GitHub pages and Jekyll work, this is the only page that needs to be in the root directory of the project, and needs to be titled `index.md`. However, it's symlinked to the `_pages/home.md` file, so the only real place to edit that page should be through editing the `_pages/home.md` instead of the `index.md` file.
