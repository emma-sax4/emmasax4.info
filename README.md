# emma-sax4.github.io [![Build Status](https://travis-ci.com/emma-sax4/emma-sax4.github.io.svg?branch=master)](https://travis-ci.com/emma-sax4/emma-sax4.github.io)

#### Live site at: [https://emmasax4.info](https://emmasax4.info)

## Basic Information

For more information on contributing to this project, please see [CONTRIBUTING.md](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.github/CONTRIBUTING.md).

To submit a feature request or a bug ticket, please use submit an official [GitHub Issue](https://github.com/emma-sax4/emma-sax4.github.io/issues/new/choose).

For information on licensing, please see [LICENSE](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/LICENSE).

A brief reminder that this repository does have a standard [Code of Conduct](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.github/CODE_OF_CONDUCT.md)... please follow it.

This page was originally generated using the [Cayman theme](https://github.com/jasonlong/cayman-theme) by [Jason Long](https://twitter.com/jasonlong).

## Running Locally

To run this application locally, following these steps:
1. Be sure you have Ruby installed on your machine; the `.ruby-version` file specifies ruby 2.3.0 because that's what's required for Jekyll and `github-pages` to run
2. First, bundle install and install all of the gems specified in the Gemfile:
    ```
    gem install bundler -v 1.17.3
    bundle install
    ```
3. Initialize the submodule and make sure it's on commit `6a8733ea0f3c079fe4a37c1828297d8f661ccee8`. Once things are initialized, there should be no need to be committing to this directory.
    ```
    git submodule update --init --recursive
    ```
4. Then build the site using Jekyll:
    ```
    jekyll build
    ```
5. Serve it up:
    ```
    jekyll serve
    ```
6. Navigate to the local URL Jekyll provides (`http://127.0.0.1:4000` on my machine)

NOTE: Running this process locally will most likely create at least one directory locally on your machine, such as `_site/`, `Gemfile.lock`, `.sass-cache/`, and potentially others. All of these are already in the `.gitignore`, but feel free to add others as necessary.

## Running Tests

This repository doesn't really have any tests at all (GitHub Pages is just a host of static site files, so there's no functionality to test). I do run TravisCI tests on every pull request and commit to master branch, but, as you can see from the [`.travis.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.travis.yml), all the Travis run does is run `script: true`, so the builds will always pass (assuming `bundle` can properly install the dependencies as well).

## Deployments

GitHub automatically deploys each commit to master branch. A full deployment only takes a couple of minutes, but depending on what was changed (HTML files, images, etc), it can take up to about 5 minutes to propagate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.

## Structure of this Project

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
├── _post_labels
|   ├── sets.md
|   |   └── posts_set_name.md
|   ├── tags.md
|   |   ├── tag_name.md
|   └── └── another_tag_name.md
├── _posts
|   ├── posts-set
|   |   ├── 2001-01-01-set-post-01.md
|   |   └── 2001-01-02-set-post-02.md
|   ├── 2001-01-03-post-01.md
|   └── 2001-01-04-post-02.md
├── assets
|   ├── css
|   |   └── style.scss
|   ├── images
|   |   ├── favicons
|   |   |   └── favicon.ico
|   |   ├── picture-01.jpg
|   |   ├── picture-02.jpg
|   |   ├── picture-03.png
|   |   └── picture-04.jpg
|   ├── resources
|   |   ├── resource-01.pdf
|   └── └── resource-02.pdf
├── primer
|   └── https://github.com/primer/css/tree/6a8733ea0f3c079fe4a37c1828297d8f661ccee8
├── _config.yml
├── Gemfile
└── index.md
```

Let's go through what each section does, from the top.

### `_drafts/`

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

### `_includes/`

HTML files in this directory are for page elements, such as the header, footer, buttons, etc. Each element belongs in its own file. By placing these elements here, they can be reused on multiple pages without duplicating any code, and they reduce the clutter in busy pages. To call one of the elements, simply include the file in any other Markdown/HTML file:
```
{% include header.html %}
```

### `_layouts/`

HTML files in this directory are for the skeletons of a specific page. The `default.html` is the plainest of the plain. It includes the head, header, and footer, and defines the body and main content of the page. The other HTML files in the directory are for more detailed pages, such as the homepage and listing posts. To specify that a certain page should use a specific layout, write that as the `layout` in the top of any other Markdown/HTML file:
```
---
layout: default
.
.
.
---
```

### `_pages/`

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

### `_post_labels/`

See the below section on `_posts/`.

### `_posts/`

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

Let's talk about the `tags`. The tags determine how we want to categorize each post. If there's no categorization of a post (if it's completely random), then there's no need to specify any `tag(s)`, AKA just leave the line completely out of the front matter. But, if you think the post is a good contestant for a tag, such as `tag_name` or `another_tag_name` in our example, then add those appropriate tags in a list format.

For every tag, there needs to be a `<tag-name>.md` file in the `_post_labels/tags/` directory. The general file for this should look like this:
```
---
layout: blog
title: Tag Name
permalink: /tag/tag-name
tag: tag_name
---

<h1>{{ page.title }}</h1>
```

The `tag` front matter indicates which posts to show on that page (only the posts with that tag will show).

### Posts in a Set

If I'm going to write a set of posts that all have a common theme, they can go into a new nested directory: `_posts/<set-name>/`. If that's the case, then there should also be a Markdown file titled `<set-name>.md` inside `_post_labels/sets/`, which would serve as a table of contents for the posts in that set. Here's an example of what that table of contents page should look like:
```
---
layout: blog
title: Posts Set
permalink: /set/posts-set
set: Posts Set
---

<h1>{{ page.title }}</h1>

Some words describing this set should go here.
```

The `set` front matter indicates which posts to show on that page, so only posts that belong to that single set will be on the page. This should be the same as the set name but with underscores. The permalink should have the name of the set, but with dashes.

Each individual post should sit inside the `_posts/<set-name>/` directory, and should make use of the `title` and `subtitle` metadata, where the `title` is the name of the set, and the `subtitle` is the title of that specific post:
```
---
layout: post
title: Posts Set
subtitle: Set Post 1
set: Posts Set
---
```

Currently, the code is not set up to handle posts that are part of a set **and** contain tags.

### `assets/`

This directory has three directories, `css/`, `images/`, and `resources/`. `css/` only has one file — `style.scss`. This is where I can keep _all_ of the CSS that this project uses. To make sure it's all being used, there is one very important line in the `_includes/head.html`:
```
<link rel="stylesheet" href="{{ "assets/css/style.css" | relative_url }}">
```

Without that line, none of the CSS would show up as expected.

The `images/` directory gives me a place to store all of the images this site uses. By putting them all into one directory (that's nested as necessary), it provides some organization to the repository. To call a specific resource, you can either ask for it in HTML:
```
<div>
  <img src="/assets/images/picture-01.jpg" alt="Picture 1">
</div>
```

The `resources/` directory gives me a place to keep PDF documents that are linked in this site. You can put a link to it in Markdown:
```
This is an example sentence, so it will throw a 404. See [here](/assets/resources/resource-01.pdf)?
```

### `primer/`

This is a submodule to [primer/css](https://github.com/primer/css/tree/6a8733ea0f3c079fe4a37c1828297d8f661ccee8) at a certain commit. This is necessary to get the pagination working. Without having this submodule initialized, running this repository locally will not work. To initialize after cloning, please run:
```
git submodule update --init --recursive
```

and make sure it's on commit `6a8733ea0f3c079fe4a37c1828297d8f661ccee8`. Once things are initialized, there should be no need to be committing to this directory.

### `_config.yml`

This is where we tell Jekyll all of the configurations for this project. Each time this file is changed, restart your local Jekyll server to get the new changes.

### `Gemfile`

The Gemfile is where the application defines which Ruby gems are important to run the application. To learn how to use this file, see this [section](https://github.com/emma-sax4/emma-sax4.github.io#running-locally).

### `index.md`

This is the first page that the site sees. Because of the way GitHub pages and Jekyll work, this is the only page that needs to be in the root directory of the project, and needs to be titled `index.md`. However, it's symlinked to the `_pages/home.md` file, so the only real place to edit that page should be through editing the `_pages/home.md` instead of the `index.md` file.
