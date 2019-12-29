# Structure of this Project

Here are all of the parts of this project associated with running this application. This list does not include files/directories related to GitHub, Travis, Git, etc.
```
.
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── default.html
|   ├── layout-01.html
|   └── layout-02.html
├── _pages
|   ├── page-01.md
|   ├── page-02.md
|   └── page-03.md
├── _posts
|   ├── posts-category
|   |   ├── 2001-01-01-categorized-post-01.md
|   |   └── 2001-01-02-categorized-post-02.md
|   ├── 2001-01-03-post-01.md
|   └── 2001-01-04-post-02.md
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
├── blog
|   ├── another_tag_name.html
|   ├── index.html
|   ├── posts_category_name.html
|   └── tag_name.html
├── _config.yml
├── Gemfile
├── Gemfile.lock
└── index.md
```

Let's go through what each section does, from the top.

## `_includes/`

HTML files in this directory are for page elements, such as the header, footer, buttons, etc. Each element belongs in its own file. By placing these elements here, they can be reused on multiple pages without duplicating any code, and they reduce the clutter in busy pages. To call one of the elements, simply include the file in any other Markdown/HTML file:
```
{% include header.html %}
```

## `_layouts/`

HTML files in this directory are for the skeletons of a specific page. The `default.html` is the plainest of the plain. It includes the head, header, and footer, and defines the body and main content of the page. The other HTML files in the directory are for more detailed pages, such as the homepage and listing posts. To specify that a certain page should use a specific layout, write that as the `layout` in the top of any other Markdown/HTML file:
```
---
layout: default
.
.
.
---
```

## `_pages/`

These are the general pages in the top navigation bar of the site, although technically there are several other pages in there as well. They're written in Markdown, but Jekyll and liquid will use the Markdown content to make HTML files. The front matter of any Markdown/HTML file specifies the settings of the page:
```
---
layout: default # the layout HTML to use (required for EVERY page)
title: Page 1 # the title of this page (optional if the page is NOT in the nav bar)
order: 3 # the order of this page in the navigation bar (delete if the page is NOT in the nav bar)
permalink: /page1 # the static link this page should have (required for EACH page in this directory)
---
```

You can also specify custom settings that you want the page to have:
```
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

## `_posts/`

These are all of blog posts I've written.

### Posts with and without Tags

Most of the posts can just go into the general `_posts/` directory, written as Markdown files. For a generic post, the front matter could look like this:
```
---
layout: post
title: Post 1
tags: [ tag_name, another_tag_name ] # optional
---
```

Let's talk about the `tags`. The tags determine how we want to categorize each post. If there's no categorization of a post (if it's completely random), then there's no need to specify any `tag(s)`, AKA just leave the line completely out of the front matter. But, if you think the post is a good contestant for a tag, such as `tag_name` or `another_tag_name` in our example, then add those appropriate tags in a list format, as shown above.

### Posts in a Collection

> Please notice that in the code, we need to call a collection of related posts a `category`. This is in order to make the pagination work as expected. A user of the site will view the collection no differently than with a tag. The difference between a `tag` and a `category`/collection is that a post can have multiple tags, but can only be a part of one collection/`category`.

If I'm going to write a collection of posts that all have a common theme, they can each go into a new nested directory: `_posts/<set-name>/`, and should make use of the `title` and `subtitle` metadata, where the `title` is the name of the collection, and the `subtitle` is the title of that specific post:
```
---
layout: post
title: Posts Category
subtitle: Post Category Post 1
category: Posts Category
---
```

Currently, the code is not set up to handle posts that are part of a collection **and** contain tags.

### Writing Drafts

To write drafts, make a new file in the `_posts/` directory (or in a subdirectory if the post will be part of a category/collection). The new file should be named in the following pattern: `YYYY-MM-DD-test-post-title`. Because this draft hasn't been published yet, I usually just put in either the date I hope to publish the draft, or the day I'm starting the draft. Make sure the date in the title is the most recent date compared to the other posts.

Then, make sure the front matter of the draft looks like this:
```
---
layout: post
title: Test Post
tags: [ tag_name, optional_tag_name ]
draft: true
---
```

If the post is part of a collection, then it should look like this:
```
---
layout: post
title: Test Post
subtitle: Post Subtitle
category: Posts Category
draft: true
---
```

Then, when you run `jekyll serve` locally, any drafts should appear at the top of the list of posts, and should show as "Unpublished".

When it's time to publish a draft, rename the file to include today's publishing date in the title (instead of whatever date was there previously), and remove the `draft: true` line from the front matter.

## `assets/`

This directory has three directories, `css/`, `images/`, and `resources/`. The `css/` directory contains all of the CSS files in this site. They're all called together in `style.scss`. The CSS in the project is loaded inside the `_includes/head.html`. This site also uses [Bootstrap](https://getbootstrap.com/docs/4.4/getting-started/introduction/) for a lot of its CSS, including the navigation bar, headers, responsive page, etc.

The `images/` directory gives me a place to store all of the images this site uses. To call a specific resource, you can either ask for it in HTML:
```
<div>
  <img class="my-image" src="/assets/images/picture-01.jpg" alt="Picture 1">
</div>
```

The `resources/` directory gives me a place to keep PDF documents that are linked in this site. You can put a link to it in Markdown:
```
This is an example sentence, so it will throw a 404. See [here](/assets/resources/resource-01.pdf)?
```

## `blog/`

This site uses [`jekyll-paginate-v2`](https://github.com/sverrirs/jekyll-paginate-v2/) to do it's pagination of the blog posts. Because of this, we must specify the blog page in its own directory, titled `blog/index.html`. There shouldn't really be a need to change the front matter of this page.

> Please notice that in the code, we need to call a collection of related posts a `category`. This is in order to make the pagination work as expected. A user of the site will view the collection no differently than with a tag. The difference between a `tag` and a `category`/collection is that a post can have multiple tags, but can only be a part of one collection/`category`.

Besides paginating the normal `blog/index.html` page, we also paginate the `tag` and `category`/collection filtered pages. So, each `tag` and `category`/collection needs to have its own page in the `blog/` directory. An example would be `blog/tag_name.html`.

For a tag, the front matter should look like this:
```html
---
layout: blog
permalink: /blog/tag-name/
url_shortname: /tag-name
pagination:
  enabled: true
  collection: posts
  permalink: /:num/
  title: Posts about Tag Name
  tag: tag-name
---
```

For a `category`/collection, the front matter should look like this:
```html
---
layout: blog
permalink: /blog/posts-category-name/
url_shortname: /posts-category-name
pagination:
  enabled: true
  collection: posts
  permalink: /:num/
  title: Posts within this Posts Category
  category: Posts Category
---

<p>
  Some words describing this collection should go here.
</p>
```

The `url_shortname` section is important... it should start with a `/`, followed by the ending part of the `permalink` without the last `/`. In order for pagination to work, this **must** be included. The `category: Posts Category` or `tag: tag-name` indicates which posts to show on that specific page.

## `_config.yml`

This is where we tell Jekyll all of the configurations for this project. Each time this file is changed, restart your local Jekyll server to get the new changes.

## `Gemfile` and `Gemfile.lock`

The Gemfile is where the application defines which Ruby gems are important to run the application. To learn how to use these files, see this [section](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/.github/CONTRIBUTING.md#running-locally).

## `index.md`

This is the first page that the site sees. Because of the way GitHub pages and Jekyll work, this is the only page that needs to be in the root directory of the project, and needs to be titled `index.md`. However, it's symlinked to the `_pages/home.md` file, so the only real place to edit that page should be through editing the `_pages/home.md` instead of the `index.md` file.