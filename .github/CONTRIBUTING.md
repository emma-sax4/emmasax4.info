# Contributing

## Contribution Process

1. Fork this repository: https://github.com/emma-sax4/emma-sax4.github.io/fork
2. Make your changes on a feature branch:

  | With GitHub UI | On your computer with Git |
  |----------------|---------------------------|
  | Make your first change. | Make sure you have this repository cloned to your machine and then create your feature branch. <br>`git checkout -b my-new-feature-branch` |
  | When you're ready to commit your first change, make a new branch and name it appropriately. | Make your first few changes. |
  | Click that green `Commit changes` button. | Commit and push your changes.<br>`git commit -am "Add some feature" && git push` |
  | Make a new pull request for your new branch (GitHub UI should automatically direct you to do this). | Continue making changes and committing/pushing them (unless you leave your feature branch, all new commits will be automatically added to your branch). |
  | Continue making changes to your pull request/branch (navigate to the main repository page, switch to your feature branch, and then continue making whatever changes you'd like). | When you're satisfied, make a pull request to this repository in the GitHub UI. |

3. Verify TravisCI passes on your pull request. The test configuration lives inside the [`.travis.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.travis.yml) file. Read more about this repository's tests below.
4. Check the site looks like how you expect it to look. Follow the instructions below to get your computer running the site locally. If you've been working on GitHub UI up until this point, you may need to switch over to a computer and clone the repository and branch to do this.
5. When you're absolutely ready for me to look at your pull request, please request a Code Review from me in the pull request.

If I don't comment or start looking at the pull request in a few days, feel free to [send me an email](mailto:emma.sax4@gmail.com).

Happy coding! 🤗

## Running Locally

To run this application locally, following these steps:
1. Be sure you have Ruby installed on your machine; the `.ruby-version` file specifies ruby 2.3.* because that's what's required for Jekyll and `github-pages` to run
2. First, bundle install and install all of the gems specified in the Gemfile:
    ```
    gem install bundler
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

This repository doesn't really have any tests at all (GitHub Pages is just a host of static site files, so there's no functionality to test). However, I do like to check that `bundle` can install the necessary dependencies and that Jekyll can properly build the site on each pull request and commit to `master` branch.

## Deployments

GitHub automatically deploys each commit to master branch. A full deployment only takes a couple of minutes, but depending on what was changed (HTML files, images, etc), it can take up to about 5 minutes to propagate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.
