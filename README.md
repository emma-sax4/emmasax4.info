# emma-sax4.github.io [![Code Climate](https://codeclimate.com/github/emma-sax4/emma-sax4.github.io/badges/gpa.svg)](https://codeclimate.com/github/emma-sax4/emma-sax4.github.io) [![Build Status](https://travis-ci.com/emma-sax4/emma-sax4.github.io.svg?branch=master)](https://travis-ci.com/emma-sax4/emma-sax4.github.io)

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
GitHub automatically deploys each commit to master branch. A full deploy only takes a couple of minutes, but depending on what was changed (HTML files, images, etc), it can take up to about 5 minutes to propogate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.

## Structure of this Project
```
.
├── _config.yml
├── _drafts
|   ├── draft-01.md
|   └── draft-02.md
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── layout-01.html
|   └── layout-02.html
├── _thoughts
|   ├── thoughts-group
|   |   ├── index.md
|   |   ├── group-thought-01.md
|   |   └── group-thought-02.md
|   ├── thought-01.md
|   └── thought-02.md
├── css
|   └── main.scss
├── resources
|   ├── favicons
|   |   └── favicon.ico
|   ├── logos
|   |   ├── logo-01.png
|   |   └── logo-02.jpg
|   ├── pictures
|   |   ├── picture-01.jpg
|   |   └── picture-02.jpg
|   ├── resource-01.pdf
|   └── resource-02.pdf
├── _site
├── page-01.md
├── page-02.md
└── index.md
```

Let's go through what each section does, from the top.

### `_config.yml`
This is where we tell Jekyll all of the configurations for this project. It's written in YAML format.

### `_drafts/`
This is where we can place all of the thoughts that we're not ready to publish yet. There's no need to put any thoughts into subdirectories in here, usually there's only a few drafts at a time, so it's not a big deal to leave them in the base directory. The front matter of a draft should look something like this for a generic draft:
```
---
layout: thought
title: Draft 1
categories: [ all ]
draft: true
---
```

And something like this for a draft that will eventually be grouped:
```
---
layout: thought
title: Thoughts Group
subtitle: Draft 2
categories: [ all, thoughts_group ]
draft: true
---
```

When we're ready for a draft to be published, move it into the appropriate `_thoughts/` directory, add in the `date` front matter with the current date in `YYYY-MM-DD` format, and remove the `draft: true` matter.

Drafts can only be seen when working locally (that's the point of a draft!). So, to run this project to see drafts, add the `--drafts` flag:
```
jekyll serve --drafts
```

The drafts should appear at the top of the list of thoughts on any thoughts list page.

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
permalink: /page/1
---
```

### `_thoughts/`
This is the collection of "thoughts" that I've had ("thought"/"thoughts" are the very non-creative terms I've come up with instead of using "post"/"blog"). Most of the thoughts can just go into the directory, written as Markdown files.

If I'm going to write a set of thoughts that all have a common theme, they can go into a nested directory inside `_thoughts/`. If that's the case, then there should also be an `index.md` inside that inner directory, which would serve as a table of contents for the thoughts related to that category.
```
---
layout: thoughts
title: Thoughts Group
permalink: /thoughts/thoughts-group
category: thoughts_group
---
```
The `category` will be what Jekyll will use to filter out which thoughts to show on each given index page.

For a generic thought, the front matter should look like this:
```
---
layout: thought
title: Thought 1
date: '2001-01-01'
categories: [ all ]
---
```

For a thought in a nested group, the front matter should look like this:
```
---
layout: thought
title: Thoughts Group
subtitle: Group Thought 1
date: '2001-01-01'
categories: [ all, thoughts_group ]
---
```
This indicates the date that the thought was published, the subtitle if the thought is in a group, the chosen layout to use, and the category/ies indicating when this thought should show up in any lists we make. We do this so that the `index.md` files don't show up as their own thoughts (since they're technically a list of thoughts).

### `css/`
This directory only has one file — `main.scss`. This is where I can keep _all_ of the CSS that this project uses. To make sure it's all being used, there are two very important lines in the `_includes/head.html`:
```
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="{{ "css/main.css" | relative_url }}">
```
Without these lines, none of the CSS or fonts would show up as expected.

### `resources/`
This directory gives me a place to store handy items, such as my resume(s), pictures, logos, past slides from tech talks, etc. By putting them all into one directory (that's nested as necessary), it provides some organization to the repository. To call a specific resource, you can either ask for it in HTML:
```
<div>
  <img src="resources/pictures/picture-01.jpg" alt="Picture 1">
</div>
```

Or you can put a link to it in Markdown:
```
This is an example sentence, so the link will throw a 404. See this in action [here](resources/resource-01.pdf).
```

### `_site/`
This directory should only exist on your local machine... otherwise it's in the `.gitignore`. This is auto-generated when a user runs `jekyll build` or `jekyll serve` on their local machine. This directory is what compiles all of the Markdown, liquid, and HTML files into plain, static HTML to show to the world on a browser. While developing locally, if you need to do a hard-restart on your Jekyll server, feel free to stop the local server process, `rm -rf` this directory, and then try again.

### Any Markdown or HTML file
This is the first page that a user will see when they navigate to the main URL of this site. It's written in Markdown, but Jekyll and liquid will use the Markdown content to make an HTML file. The front matter of any Markdown/HTML file specifies the settings of the page:
```
---
layout: default # the layout HTML to use
title: Page 1 # the title of this page
order: 3 # the number of this page in the navigation bar (you're essentially setting what order the navigation bar's pages should be in)
permalink: /page/1 # the static permalink that this page should have
pagination: # this is for the pagination gem (see more on pagination: https://github.com/sverrirs/jekyll-paginate-v2)
  enabled: true
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
