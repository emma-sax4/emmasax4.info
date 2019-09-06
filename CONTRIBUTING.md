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

This repository is set up with basic Jasmine tests that are run automatically on TravisCI upon each commit. To see a full list of what the tests do, view the [`.travis.yml`](https://github.com/emma-sax4/emma-sax4.github.io/blob/master/.travis.yml) file. But in short, the tests:
1. Run `bundle install`
2. Run `jasmine`

The `jasmine` command runs the five default tests that come when Jasmine is installed. There are no tests to test any actual functionality of this repository (since GitHub Pages only support static site files anyway).
