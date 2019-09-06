# Contributing

To contribute, please follow this step-by-step process:
1. Fork this repository (https://github.com/emma-sax4/emma-sax4.github.io/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Continue making awesome changes!
6. To see what they look like, follow the instructions in the [Running Locally](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/CONTRIBUTING.md#running-locally) section
7. When you're satisfied, make a pull request to this repository
8. If I don't comment or start looking at the pull request in a couple of days, feel free to send me [an email](mailto:emma.sax4@gmail.com)
9. I approve your pull request and merge!

## Running Locally

It is totally possible to run this site locally!

1. First, install the `github-pages` gem:
    ```
    gem install bundler
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
