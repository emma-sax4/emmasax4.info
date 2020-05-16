# Contributing

### Table of Contents
- [Contribution Process](#contribution-process)
- [Running Locally](#running-locally)
- [HTML Proofer](#html-proofer)
- [Continuous Integration](#continuous-integration)
  * [Tests](#tests)
  * [Deployments](#deployments)
  * [Notifications](#notifications)
- [Collections vs. Categories vs. Tags](#collections-vs-categories-vs-tags)
- [Directory/File Structure](#directoryfile-structure)
  * [`.github/`](#github)
  * [`_includes/`](#_includes)
  * [`_layouts/`](#_layouts)
  * [`_pages/`](#_pages)
    - [`_pages/blog/`](#_pagesblog)
  * [`_posts/`](#_posts)
    - [Posts with and without Tags](#posts-with-and-without-tags)
    - [Posts in a Collection](#posts-in-a-collection)
    - [Writing Drafts](#writing-drafts)
  * [`assets/`](#assets)
  * [`js/`](#js)
  * [`_config.yml`](#_configyml)
  * [`favicon.ico`](#faviconico)
  * [`Gemfile` and `Gemfile.lock`](#gemfile-and-gemfilelock)

## Contribution Process

1. Fork this repository: https://github.com/emma-sax4/emma-sax4.github.io/fork.
2. Triple check you're currently on the `source` branch.
3. Make your changes on a feature branch:

  | With GitHub UI | On your computer with Git |
  |----------------|---------------------------|
  | Make your first change. | Make sure you have this repository cloned to your machine and then create your feature branch. <br>`git checkout -b my-new-feature-branch` |
  | When you're ready to commit your first change, make a new branch and name it appropriately. | Make your first few changes. |
  | Click that green `Commit changes` button. | Commit and push your changes.<br>`git commit -am "Add some feature" && git push` |
  | Make a new pull request for your new branch (GitHub UI should automatically direct you to do this). | Continue making changes and committing/pushing them (unless you leave your feature branch, all new commits will be automatically added to your branch). |
  | Continue making changes to your pull request/branch (navigate to the main repository page, switch to your feature branch, and then continue making whatever changes you'd like). | When you're satisfied, make a pull request to this repository in the GitHub UI. |

4. Verify tests passes on your pull request. The test configuration lives inside the [`..github/workflows/config.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/source/.github/workflows/config.yml) file. Read more about this repository's tests below.
5. Check the site looks like how you expect it to look. Follow the instructions below to get your computer running the site locally. If you've been working on GitHub UI up until this point, you may need to switch over to a computer and clone the repository and branch to do this.
6. When you're absolutely ready for me to look at your pull request, please request a Code Review from me in the pull request. If I don't comment or start looking at the pull request in a few days, feel free to [send me an email](mailto:emma.sax4@gmail.com).

\* If you're getting stuck on understanding this project or its file structure, take a peek [here](#directoryfile-structure).

Happy coding! 🤗

## Running Locally

To run this application locally, following these steps:
1. Be sure you have Ruby installed on your machine; the `.ruby-version` file specifies ruby 2.6.5 because that's the latest stable version of Ruby.
2. First, bundle install and install all of the gems specified in the Gemfile:
    ```bash
    gem install bundler
    bundle install
    ```
3. Then build and serve the site using Jekyll:
    ```bash
    bundle exec jekyll serve # with optional --future flag
    ```
4. Navigate to the local URL Jekyll provides (`http://127.0.0.1:4000` on my machine).

To view Disqus comments and comment loading locally, run Jekyll in the `production` environment (local development, where the environment is automatically `development`, does not show comments):
```bash
JEKYLL_ENV=production bundle exec jekyll serve # with optional --future flag
```

NOTE: Running this process locally will most likely create at least one directory locally on your machine, such as `_site/` and `.sass-cache/`, and potentially others. All of these are already in the `.gitignore`, but feel free to add others as necessary.

## HTML Proofer

We can check periodically that all of the HTML links in this website load correctly:
```bash
JEKYLL_ENV=production bundle exec jekyll build
bundle exec htmlproofer --assume-extension --allow-hash-href --internal-domains /emmasax4.info/ --only_4xx ./_site/
```

If you're in the process of creating a new blog post, then most likely the external link to the new blog post will fail. This makes sense—the blog post isn't live online yet, and that's what the link is checking for.

GitHub Actions also runs a version of the HTML Proofer which skips over all internal domains. GitHub Actions runs this step after building, just verifying that links are accurate. If a build breaks because of this, the failures can probably be solved by just rerunning the workflow.

## Continuous Integration

This repository uses GitHub Actions for continuous integration tools. See the full workflows [here](https://github.com/emma-sax4/emma-sax4.github.io/blob/source/.github/workflows).

### Tests

This repository doesn't really have any unit or integration tests (Jekyll sites are just a host of static site files, so there's not really any functionality to test). However, GitHub Actions does check that Bundler can install the necessary dependencies and that Jekyll can properly build the site on each pull request and each commit to the `source` branch (the default branch in this repository). The tests are also run on a weekly cron (on Monday mornings) as a way of testing that the building continues to function as expected.

### Deployments

Because of the use of Jekyll gems that GitHub Pages doesn't support, this site needs to use a "3rd party" instead of GitHub Pages to compile the code. So, when GitHub Actions runs on the `source` branch, not only does it bundle all of the dependencies and build the site, but it also puts it into a special `./_site` directory. Then, GitHub Actions will run a "deployment" to GitHub Pages to upload that directory to the `master` branch of this GitHub repository. Then, GitHub Pages automatically deploys the commits in the `master` branch. In this way, we develop the site on a pull request, we merge pull request into the `source` branch, and then GitHub Actions builds the code and commits that automagically to the `master` branch. Then GitHub Pages does their thing.

A full deployment (including GitHub Actions and GitHub Pages) only takes about five to ten minutes, but depending on what was changed (HTML files, images, etc), it can take up to about fifteen minutes to propagate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.

### Notifications

GitHub Actions sends a Slack notification indicating the build status after each action build finishes (even on pull requests). The Slack notifications are sent to the Slack workspace [emmasax4](https://emmasax4.slack.com). You can ask for an invite to that workspace, but a final invite is not guaranteed. The workspace and notifications are set up for my personal usage, not for communciational purposes.

## Collections vs. Categories vs. Tags

Please notice that in the code, we need to call a collection of related posts a `category`. This is in order to make the pagination work as expected. A user of the site will view the collection no differently than with a tag. The biggest difference between a `tag` and a `category` is that a post can have multiple tags, but can only be a part of one `category`. Currently, the code is not set up to handle posts that are part of a collection _and_ contain tags.

## Directory/File Structure

Here are all of the parts of this project associated with running this application. This list does not include files/directories related to Git.
```
.
├── .github
|   ├── ISSUE_TEMPLATE
|   |   └── template.md
|   ├── workflows
|   |   └── main.yml
|   ├── another-file.md
|   ├── file.md
|   ├── PULL_REQUEST_TEMPLATE.md
|   └── template.md
├── _includes
|   ├── elements
|   |   ├── button-one.html
|   |   └── button-two.html
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
|   |   ├── category-one.md
|   |   ├── category-two.md
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
|   |   ├── css-file-01.scss
|   |   ├── css-file-02.scss
|   |   └── style.scss
|   ├── favicon
|   |   ├── android-chrome.png
|   |   ├── apple-touch-icon.png
|   |   ├── browserconfig.xml
|   |   └── site.webmanifest
|   ├── images
|   |   ├── picture-01.jpg
|   |   ├── picture-02.jpg
|   |   ├── picture-03.png
|   |   └── picture-04.jpg
|   ├── resources
|   |   ├── resource-01.pdf
|   └── └── resource-02.pdf
├── js
|   ├── another-script.js
|   ├── one-more-script.js
|   └── script.js
├── _config.yml
├── favicon.ico
├── Gemfile
└── Gemfile.lock
```

### `.github/`

This site builds and "deploys" through GitHub Actions.

### `_includes/`

HTML files in this directory are for page elements, such as buttons, icons, images. It is also for divs that are long or have Jekyll/Liquid logic. Each div or element should have its own file in the appropriate directory. By placing these elements here, they can be reused on multiple pages without duplicating code, and they reduce the clutter in busier pages. To call one of the elements, simply include the file in any other Markdown/HTML file:
```markdown
{% include site/header.html %}
```

### `_layouts/`

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

### `_pages/`

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

#### `_pages/blog/`

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

### `_posts/`

These are all of blog posts I've written.

### Posts with and without Tags

Most of the posts can just go into the general `_posts/` directory, written as Markdown files. For a generic post, the front matter could look like this:
```yml
---
layout: post
title: Post A
tags: [ tag1, tag2 ] # optional
permalink: /blog/posts/post-a
date: 2001-12-14 00:00:00 -0600 # 2001-12-14 06:00:00 UTC
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
date: 2001-06-27 20:30:00 -0500 # 2001-06-28 01:30:00 UTC
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
  * Merge the pull request into the `source` branch
* Publish the post on a future date:
  * Add the future publishing date/time (typically 00:00:00 in the author's local time zone, properly identifying current the hour offset from UTC) to the post's front matter in the `date` value
  * Rename the file to have the publishing date in the title instead of whatever was there previously
  * Re-add and commit that file to the pull request
  * Wait for your pull request's tests to finish
  * Add the `auto-merge` label to the pull request
  * Switch to the `source` branch
  * Change the `.github/workflows/auto_merge_pull_requests.yml` cron schedule to be the publish date/time in UTC (you can set the day of the week, day of the month, and the month to run your merge)
  * Re-add and commit that file to the default branch directly
  * Wait until GitHub Actions auto-merges your pull request, and then will trigger a build and deploy of your changes

To identify the current hour offset from UTC, look up the time zone offset based on your location [here](https://www.timeanddate.com/time/zone/).

### `assets/`

This directory has four directories, `css/`, `favicon/`, `images/`, and `resources/`. The `css/` directory contains all of the CSS files in this site. They're all called together in `style.scss`. The CSS in the project is loaded inside the `_includes/head.html`. This site also uses [Bootstrap](https://getbootstrap.com/docs/4.4/getting-started/introduction/) for a lot of its CSS, including the navigation bar, headers, responsive page, etc.

The `favicon/` directory contains files and multiple icons of different names for favicon displays on Android, iOS, Safari, Chrome, Firefox, IE, and Edge.

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

### `js/`

This directory is where we store all of our javascript files for the site. Some of them are called at the bottom of every page. Others are called in specific places in the code. All of these are parsed by Code Climate.

### `_config.yml`

This is where we tell Jekyll all of the configurations for this project. Each time this file is changed, restart your local Jekyll server to get the new changes.

### `favicon.ico`

The favicon of the site is the main image associated with the site. It's the small square image that we see on the browser tab, and it's the general logo on this site. It's placed in the root directory so that browser crawlers and bots can easily locate it and show it on search results. It improves this site's SEO.

### `Gemfile` and `Gemfile.lock`

The Gemfile is where the application defines which Ruby gems are important to run the application. To learn how to use these files, see this [section](#running-locally).
