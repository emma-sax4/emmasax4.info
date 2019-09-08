# emma-sax4.github.io [![Code Climate](https://codeclimate.com/github/emma-sax4/emma-sax4.github.io/badges/gpa.svg)](https://codeclimate.com/github/emma-sax4/emma-sax4.github.io) [![Build Status](https://travis-ci.com/emma-sax4/emma-sax4.github.io.svg?branch=master)](https://travis-ci.com/emma-sax4/emma-sax4.github.io)

#### Live site at: [https://emma-sax4.github.io](https://emma-sax4.github.io)

For more information on contributing to this project, please see [CONTRIBUTING.md](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/CONTRIBUTING.md).

To submit a feature request or a bug ticket, please use submit an official [GitHub Issue](https://github.com/emma-sax4/emma-sax4.github.io/issues/new/choose).

For information on licensing, please see [LICENSE](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/LICENSE).

And a brief reminder that this repository does have a standard [Code of Conduct](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/CODE_OF_CONDUCT.md)... please follow it.

This page was originally generated using the [Cayman theme](https://github.com/jasonlong/cayman-theme) by [Jason Long](https://twitter.com/jasonlong).

## Running Locally

It is totally possible to run this site locally!

1. First, bundle install and install all of the gems specified in the Gemfile:
    ```
    gem install bundler -v 1.17.3
    bundle install
    ```
2. Then build the site using Jekyll:
    ```
    jekyll build
    ```
3. Serve it up:
    ```
    jekyll serve
    ```
4. Navigate to the local URL Jekyll provides (`http://127.0.0.1:4000` on my machine).

## Tests
This repository doesn't really have any tests at all (GitHub Pages is just a host of static site files, so there's no functionality to test). I do run TravisCI tests on every pull request and commit to master branch, but, as you can see from the [`.travis.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.travis.yml), all the Travis run does is run `script: true`, so the builds will always pass (assuming `bundle` can properly install the dependencies as well).

## Deploys
GitHub automatically deploys each commit to master branch. A full deploy only takes a couple of minutes, but depending on what was changed (HTML files, images, etc), it can take up to about 5 minutes to propogate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.
