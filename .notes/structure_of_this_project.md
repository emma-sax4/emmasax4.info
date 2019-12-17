# Structure of this Project

Here are all of the parts of this project associated with running this application. This list does not include files/directories related to GitHub, Travis, Git, etc.
```
.
├── _drafts
|   ├── set-post-draft.md
|   └── post-draft.md
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
|   ├── posts-set
|   |   ├── 2001-01-01-set-post-01.md
|   |   └── 2001-01-02-set-post-02.md
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
|   ├── posts_set_name.html
|   └── tag_name.html
├── primer
|   └── https://github.com/primer/css/tree/6a8733ea0f3c079fe4a37c1828297d8f661ccee8
├── _config.yml
├── Gemfile
└── index.md
```

Let's go through what each section does, from the top.

## `_drafts/`

Drafts should always be written in a pull request in new branch. This will allow the author of the post to let it sit for as long as necessary, before feeling pressured to finish the post.

To write a draft, write a new post in the `_drafts/` directory, and then make sure the front matter looks somewhat like the following:
```
---
layout: post
title: Test Post
tags: [ tag_name ] OR set: Posts Set
draft: true
---
```

Then, run your local Jekyll command like such:
```
jekyll serve --drafts
```

Any drafts should appear at the top of the list of posts, and should show as "Unpublished". When it's time to publish a draft, move the draft to the `_posts/` directory, rename the file to include the publishing date (in `YYYY-MM-DD-` format... follow the previous post examples), and remove the `draft: true` line from the front matter.

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

## `_post_collections/`

See the below section on `_posts/`.

## `_posts/`

This is the collection of blog posts that I've written.

### Posts without a Set

Most of the posts can just go into the general `_posts/` directory, written as Markdown files. For a generic post, the front matter could look like this:
```
---
layout: post
title: Post 1
tags: [ tag_name, another_tag_name ]
---
```

Let's talk about the `tags`. The tags determine how we want to categorize each post. If there's no categorization of a post (if it's completely random), then there's no need to specify any `tag(s)`, AKA just leave the line completely out of the front matter. But, if you think the post is a good contestant for a tag, such as `tag_name` or `another_tag_name` in our example, then add those appropriate tags in a list format, as shown above.

### Posts in a Set

If I'm going to write a set of posts that all have a common theme, they can each go into a new nested directory: `_posts/<set-name>/`, and should make use of the `title` and `subtitle` metadata, where the `title` is the name of the set, and the `subtitle` is the title of that specific post:
```
---
layout: post
title: Posts Set
subtitle: Set Post 1
set: Posts Set
---
```

Currently, the code is not set up to handle posts that are part of a set **and** contain tags.

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

This site uses [`jekyll-paginate-v2`](https://github.com/sverrirs/jekyll-paginate-v2/) to do it's pagination of the blog posts. Because of this, we must specify the blog page in its own directory, titled `blog/index.html`. There shouldn't really be a need to change the front-matter of this page.

However, we also paginate the tag/set filters. So, each tag/set needs to have its own page in that same directory. An example would be `blog/tag_name.html`.

For a tag, the front-matter should look like this:
```html
---
layout: blog
permalink: /blog/tag-name
url_settings: /blog/tag-name/
pagination:
  enabled: true
  collection: posts
  permalink: /:num/
  title: Tag Name
  tag: tag-name
---
```

For a set, the front-matter should look like this:
```html
---
layout: blog
permalink: /blog/posts-set-name
url_settings: /blog/posts-set-name/
pagination:
  enabled: true
  collection: posts
  permalink: /:num/
  title: Posts Set Name
  set: Posts Set Name
---

<p>
  Some words describing this set should go here.
</p>
```

The `url_settings` section is important... it should match the permalink but with the trailing `/`. In order for pagination to work, this must be included. The `set: Posts Set Name` or `tag: tag-name` indicates which posts to show on that specific page.

## `_config.yml`

This is where we tell Jekyll all of the configurations for this project. Each time this file is changed, restart your local Jekyll server to get the new changes.

## `Gemfile`

The Gemfile is where the application defines which Ruby gems are important to run the application. To learn how to use this file, see this [section](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.github/CONTRIBUTING.md#running-locally).

## `index.md`

This is the first page that the site sees. Because of the way GitHub pages and Jekyll work, this is the only page that needs to be in the root directory of the project, and needs to be titled `index.md`. However, it's symlinked to the `_pages/home.md` file, so the only real place to edit that page should be through editing the `_pages/home.md` instead of the `index.md` file.
