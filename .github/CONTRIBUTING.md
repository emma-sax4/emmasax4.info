# Contributing

## Contribution Process

1. Fork this repository: https://github.com/emma-sax4/emma-sax4.github.io/fork.
2. Triple check you're currently on the `release` branch.
3. Make your changes on a feature branch:

  | With GitHub UI | On your computer with Git |
  |----------------|---------------------------|
  | Make your first change. | Make sure you have this repository cloned to your machine and then create your feature branch. <br>`git checkout -b my-new-feature-branch` |
  | When you're ready to commit your first change, make a new branch and name it appropriately. | Make your first few changes. |
  | Click that green `Commit changes` button. | Commit and push your changes.<br>`git commit -am "Add some feature" && git push` |
  | Make a new pull request for your new branch (GitHub UI should automatically direct you to do this). | Continue making changes and committing/pushing them (unless you leave your feature branch, all new commits will be automatically added to your branch). |
  | Continue making changes to your pull request/branch (navigate to the main repository page, switch to your feature branch, and then continue making whatever changes you'd like). | When you're satisfied, make a pull request to this repository in the GitHub UI. |

4. Verify Travis CI passes on your pull request. The test configuration lives inside the [`.travis.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/.travis.yml) file. Read more about this repository's tests below.
5. Check the site looks like how you expect it to look. Follow the instructions below to get your computer running the site locally. If you've been working on GitHub UI up until this point, you may need to switch over to a computer and clone the repository and branch to do this.
6. When you're absolutely ready for me to look at your pull request, please request a Code Review from me in the pull request. If I don't comment or start looking at the pull request in a few days, feel free to [send me an email](mailto:emma.sax4@gmail.com).

\* If you're getting stuck on understanding this project or its file structure, see [STRUCTURE_OF_THIS_PROJECT.md](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/.github/STRUCTURE_OF_THIS_PROJECT.md).

Happy coding! 🤗

## Running Locally

To run this application locally, following these steps:
1. Be sure you have Ruby installed on your machine; the `.ruby-version` file specifies ruby 2.6.5 because that's the latest stable version of Ruby.
2. First, bundle install and install all of the gems specified in the Gemfile:
    ```
    gem install bundler
    bundle install
    ```
3. Then build the site using Jekyll:
    ```
    bundle exec jekyll build
    ```
4. Serve it up:
    ```
    bundle exec jekyll serve
    ```
5. Navigate to the local URL Jekyll provides (`http://127.0.0.1:4000` on my machine).

To view Disqus comments and comment loading locally, run Jekyll in the `production` environment (for local development, the default does not show comments):
```
JEKYLL_ENV=production bundle exec jekyll serve
```

NOTE: Running this process locally will most likely create at least one directory locally on your machine, such as `_site/` and `.sass-cache/`, and potentially others. All of these are already in the `.gitignore`, but feel free to add others as necessary.

## Running Tests & Deployments

This repository doesn't really have any tests at all (Jekyll sites are just a host of static site files, so there's no functionality to test). However, I do want to check that `bundler` can install the necessary dependencies and that Jekyll can properly build the site on each pull request and commit to `release` branch (the default branch in this repository).

Because of the use of Jekyll gems that GitHub doesn't support, this site needs to use a 3rd Party instead of GitHub Pages to compile the code. So, here comes Travis CI to the rescue.

When Travis CI runs on the `release` branch, not only does it bundle all of the dependencies and build the site, but it also puts it into a special `./site` directory. Then, Travis CI will run a Travis Deployment to upload that directory to the `master` branch of this GitHub repository. Then, GitHub automatically deploys the commits (in the `master` branch) to GitHub Pages. In this way, we develop the site on a pull request, we merge source code into the `release` branch, and then Travis CI builds the code and commits that automagically to the `master` branch. Then GitHub Pages does their thing.

A full deployment only takes about five minutes, but depending on what was changed (HTML files, images, etc), it can take up to about ten minutes to propagate the changes. To make the changes appear faster, you can reload the entire website in incognito mode.
