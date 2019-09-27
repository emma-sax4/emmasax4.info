# emma-sax4.github.io [![Build Status](https://travis-ci.com/emma-sax4/emma-sax4.github.io.svg?branch=master)](https://travis-ci.com/emma-sax4/emma-sax4.github.io)

#### Live site at: [https://emma-sax4.github.io](https://emma-sax4.github.io)

## Basic Information
For more information on contributing to this project, please see [CONTRIBUTING.md](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/CONTRIBUTING.md).

To submit a feature request or a bug ticket, please use submit an official [GitHub Issue](https://github.com/emma-sax4/emma-sax4.github.io/issues/new/choose).

For information on licensing, please see [LICENSE](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/LICENSE).

A brief reminder that this repository does have a standard [Code of Conduct](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/CODE_OF_CONDUCT.md)... please follow it.

This page was originally generated using the [Cayman theme](https://github.com/jasonlong/cayman-theme) by [Jason Long](https://twitter.com/jasonlong).

## Running Locally
It is totally possible to run this site locally!
1. Be sure you have Ruby installed on your machine; the `.ruby-version` file specifies ruby 2.3.0 because that's what's required for Jekyll and `github-pages` to run
2. First, bundle install and install all of the gems specified in the Gemfile:
    ```
    gem install bundler -v 1.17.3
    bundle install
    ```
3. Then build the site using Jekyll:
    ```
    jekyll build
    ```
4. Serve it up:
    ```
    jekyll serve
    ```
5. Navigate to the local URL Jekyll provides (`http://127.0.0.1:4000` on my machine)

## Tests
This repository doesn't really have any tests at all (GitHub Pages is just a host of static site files, so there's no functionality to test). I do run TravisCI tests on every pull request and commit to master branch, but, as you can see from the [`.travis.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.travis.yml), all the Travis run does is run `script: true`, so the builds will always pass (assuming `bundle` can properly install the dependencies as well).

## Deploys
GitHub automatically deploys each commit to master branch. A full deploy only takes a couple of minutes, but depending on what was changed (HTML files, images, etc), it can take up to about 5 minutes to propagate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.

## Structure of this Project
```
.
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── layout-01.html
|   └── layout-02.html
├── _site
|   └── <other stuff we don't need to touch>
├── _thoughts
|   ├── thoughts-set
|   |   ├── 2001-01-01-set-thought-01.md
|   |   ├── 2001-01-02-set-thought-02.md
|   |   ├── set-thought-draft.md
|   |   └── thoughts_set.md
|   ├── 2001-01-01-thought-01.md
|   ├── 2001-01-02-thought-02.md
|   ├── thought-draft.md
|   └── tag_name.md
├── css
|   └── main.scss
├── primer
|   └── <other stuff we don't need to touch>
├── resources
|   ├── favicons
|   |   └── favicon.ico
|   ├── logos
|   |   ├── logo-01.png
|   |   └── logo-02.jpg
|   ├── picture-01.jpg
|   ├── picture-02.jpg
|   ├── resource-01.pdf
|   └── resource-02.pdf
├── _config.yml
├── page-01.md
├── page-02.md
└── index.md
```

Let's go through what each section does, from the top.

### `_includes/`
HTML files in this directory are for page elements, such as the header, footer, buttons, etc. Each element belongs in its own file. By placing these elements here, they can be reused on multiple pages without duplicating any code, and they reduce the clutter in busy pages. To call one of the elements, simply include the file in any other Markdown/HTML file:
```
{% include header.html %}
```

### `_layouts/`
HTML files in this directory are for the skeletons of a specific page. The `default.html` is the plainest of the plain. It includes the head, header, and footer, and defines the body and main content of the page. The other HTML files in the directory are for more detailed pages, such as the homepage and listing thoughts. To specify that a certain page should use a specific layout, write that as the `layout` in the top of any other Markdown/HTML file:
```
---
layout: default
title: Page 1
permalink: /page-1
---
```

### `_site/`
This directory should only exist on your local machine... otherwise it's in the `.gitignore`. This is auto-generated when a user runs `jekyll build` or `jekyll serve` on their local machine. This directory is what compiles all of the Markdown, liquid, and HTML files into plain, static HTML to show to the world on a browser. While developing locally, if you need to do a hard-restart on your Jekyll server, feel free to stop the local server process, `rm -rf` this directory, and then try again.

### `_thoughts/`
This is the collection of "thoughts" that I've had ("thought"/"thoughts" are the very non-creative terms I've come up with instead of using "post"/"blog").

#### Thoughts without a Set
Most of the thoughts can just go into the general `_thoughts/` directory, written as Markdown files. For a generic thought, the front matter could look like this:
```
---
layout: thought
title: Thought 1
tags: [ tag_name, another_tag_name ]
---
```

Let's talk about the `tags`. The tags determine how we want to categorize each thought. If there's no categorization of a thought (if it's completely random), then there's no need to specify any `tag(s)`, AKA just leave the line completely out of the front matter. But, if you think the thought is a good contestant for a tag, such as `tag_name` or `another_tag_name` in our example, then add those appropriate tags in a list format.

For every tag, there needs to be a `<tag-name>.md` file in the `_thoughts/` directory. The general file for this should look like this:
```
---
layout: thoughts
title: Tag Name
permalink: /thoughts/tag-name
tag: tag_name
---

<h1>{{ page.title }}</h1>
```

The `tag` front matter indicates which thoughts to show on that page (only the thoughts with that tag will show).

#### Thoughts in a Set
If I'm going to write a set of thoughts that all have a common theme, they can go into a new nested directory: `_thoughts/<set-name>/`. If that's the case, then there should also be a Markdown file titled `<set-name>.md` inside that inner directory, which would serve as a table of contents for the thoughts in that set. Here's an example of what that table of contents page should look like:
```
---
layout: thoughts
title: Thoughts Set
permalink: /thoughts/thoughts-set
set: thoughts_set
---

<h1>{{ page.title }}</h1>

Some words describing this set should go here.
```

The `set` front matter indicates which thoughts to show on that page, so only thoughts that belong to that single set will be on the page. This should be the same as the set name but with underscores. The permalink should have the name of the set, but with dashes.

Each individual thought should sit inside the `_thoughts/<set-name>/` directory, and should make use of the `title` and `subtitle` metadata, where the `title` is the name of the set, and the `subtitle` is the title of that specific thought:
```
---
layout: thought
title: Thoughts Set
subtitle: Set Thought 1
set: thoughts_set
---
```

Currently, the code is not set up to handle thoughts that are part of a set **and** contain tags.

#### Writing Drafts

Drafts should always be written in a pull request in new branch. This will allow the author of the thought to let it sit for as long as necessary, before feeling pressured to finish the thought.

To write a draft, write a new thought in the proper directory, and then make sure the front matter contains the following:
```
draft: true
```

Any drafts should appear at the top of the list of thoughts, and should show as "Unpublished". When it's time to publish a draft, rename the file to include the publishing date (in `YYYY-MM-DD-` format... follow the previous thought examples), and remove the `draft: true` line from the front matter.

### `css/`
This directory only has one file — `main.scss`. This is where I can keep _all_ of the CSS that this project uses. To make sure it's all being used, there are two very important lines in the `_includes/head.html`:
```
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="{{ "css/main.css" | relative_url }}">
```
Without these lines, none of the CSS or fonts would show up as expected.

### `primer/`
This is a submodule to [primer/css](https://github.com/primer/css/tree/6a8733ea0f3c079fe4a37c1828297d8f661ccee8) at a certain commit. This is necessary to get the pagination working. Without having this submodule initialized, running this repository locally will not work. To initialize after cloning, please run:
```
git submodule update --init --recursive
```
and make sure it's on commit `6a8733ea0f3c079fe4a37c1828297d8f661ccee8`. Once things are initialized, there should be no need to be committing to this directory.

### `resources/`
This directory gives me a place to store handy items, such as my resume(s), some pictures, logos, past slides from tech talks, etc. By putting them all into one directory (that's nested as necessary), it provides some organization to the repository. To call a specific resource, you can either ask for it in HTML:
```
<div>
  <img src="/resources/picture-01.jpg" alt="Picture 1">
</div>
```

Or you can put a link to it in Markdown:
```
This is an example sentence, so it will throw a 404. See [here](/resources/resource-01.pdf)?
```

### `_config.yml`
This is where we tell Jekyll all of the configurations for this project. Each time this file is changed, restart your local Jekyll server to get the new changes.

### Any Markdown or HTML file
This is the first page that a user will see when they navigate to the main URL of this site. It's written in Markdown, but Jekyll and liquid will use the Markdown content to make an HTML file. The front matter of any Markdown/HTML file specifies the settings of the page:
```
---
layout: default # the layout HTML to use
title: Page 1 # the title of this page
order: 3 # the order of this page in the navigation bar
permalink: /page-1 # the static permalink that this page should have
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
