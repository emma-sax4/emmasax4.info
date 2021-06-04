---
layout: post
title: Using <header-code>jekyll-paginate-v2</header-code>
tags: [ jekyll, tech ]
permalink: /blog/posts/using-jekyll-paginate-v2/
date: 2019-12-18 00:00:00 -0600
---

A couple of weeks ago, I started the endeavor of adding Bootstrap to this website. You can read more about how this repository uses Bootstrap, and how to add Bootstrap to a static content site [here](/blog/posts/adding-bootstrap-to-your-static-content-site/).

But, soon after I started getting an upgrade in my CSS game, I realized that my pagination bar on my blog site was sorely outdated 😢. At one point, I had the nerve to call this pagination bar beautiful:

<div class="text-center photoswipe-gallery">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/48741504061_7ebbd630fa.jpg"
      thumb_width="400" caption="Pagination bar that's now not quite as lovely"
      full_width="500" full_height="345"
  %}
</div>

But since completely revamping the whole looks of the site, this pagination bar was no longer acceptable. It was old fashioned, wouldn't remember the page you were on if you navigated forward and back in your browser, and didn't have pretty buttons. It was time for me to look into alternate pagination options.

I build and serve this site with GitHub Pages. Their built-in pagination suggestion is [`jekyll-paginate`](https://github.com/jekyll/jekyll-paginate). But, it very clearly states that `jekyll-paginate` is no longer supported. The recommended newer version of Jekyll pagination is [`jekyll-paginate-v2`](https://github.com/sverrirs/jekyll-paginate-v2).

I had considered `jekyll-paginate-v2` before, and I briefly mentioned it in [this blog post](/blog/posts/adding-pagination-without-jekyll/). At that time, I didn't want to make the necessary changes to my directory structure, and I'd have to be willing to either add a trailing `/` to the end of my URLs, or I'd have to be okay with some of my pages having that trailing `/`, and some not to, which I wasn't okay with.

From a technical standpoint, it doesn't really matter to the browser whether you write a `/` on the end of your URL or not; they resolve to the same host. There's more detailed reasons why or why to have a trailing `/` on a URL, but the gist is that the `/` delineates a directory, which then would have files in it: `https://example.com/directory/` and then `https://example.com/directory/file.html` 🤷🏻‍♀️.

In fact, my reading said that although having URLs without `/` is the newer, more popular thing, traditionalists would actually pretty much only have _either_ the trailing `/` _or_ the extension (the `.html` in the above example) in the URL. So if I'm to follow these guidelines, then I probably should add the trailing `/` to the end of all of my URLs except the home page.

I could continue doing research, trying to decide what other pagination options to explore. But I figured that if I wanted to get anything easy done reasonably soon, I'd have to just be okay with compromising on the trailing `/`.

So after admitting that I'd need to accept the trailing `/`, I proceeded to set up `jekyll-paginate-v2` on my repository. How hard could it be? 😆

I started by following the [installation instructions](https://github.com/sverrirs/jekyll-paginate-v2#installation). But, as you'll understand later, I got only got through the second line in that section; I never finished reading that doc.

Instead, I jumped right into the work, copy-pasting the basics of the needed configuration into my config file, before realizing that although there's lots of documentation in this repo, they never quite clarify that your main `Blog` page needs to be in a `./blog/index.html` file. Furthermore, they never actually say that your blog posts need to be in a `_posts/` directory. Luckily, I poked around the examples enough to figure that out.

Thanks to [this gist](https://gist.github.com/alialo/2255511), I was able to get the basic code of a simple pagination bar going right away. In fact, getting the main `Blog` page paginating wasn't too hard at all!

But, I also wanted to make sure that I could paginate my sub-pages—basically filtering my posts based on tag names and set names. On my site, an example of a tag name is `tech` and an example of a set name is `Welcome to Kenya`. The distinction between the two is that a blog post can have multiple tag names, and they should be one word long. But a blog post can only be a part of one set, and the name can be multiple words with capitalization.

Filtering posts proved to be a little bit more complicated than just paginating _all_ of the posts. The documentation for `jekyll-paginate-v2` describes filtering based on what they call "tags" and "categories." So I started with a single tag, because I wasn't quite sure yet how to deal with the sets. After I added the first bit of code to the tag's filter, I realized that the documentation never properly mentioned in what _directory_ I should put my filter's file. I tried at least four different places I should put it. It wasn't until my last idea when I realized that it had to be placed in the same `blog/` directory as the `index.html`. But, as soon as I moved my tag file into the directory, so it looked like `blog/tag.html`, then it worked miraculously.

It was then easy to move all of the tags to have the same pattern. Moving to the "set," I had more issues, mainly with 1) figuring out the best way to paginate the filtered pages, and 2) `jekyll-paginate-v2` couldn't be formatted to work with filtering a `set` (only `tags`, `categories`, and `locales`, which is languages). So, I had to write my code as if my `set` was a `category` instead. This meant changing several variable names, and in general renaming files and calls to have the word "category" instead of "set." In fact, by the end of the night, I had changed almost every reference to a "set" in the whole codebase 😝.

In fact, by the time I was done for the day, I had pretty much decided to just do-away with the whole notion of a "set" and turn it into a "category" instead. Actually I like the word "collection" more than a "category," so in the codebase it's a "category," in my head it's a "collection," and to an end user of this site, they all look like "tags." So then, I did a _huge_ find/replace of the word `set` and replaced it with the word `category`.

Despite all of this work, now every single tag and category filters blog posts properly. The last secret to getting pagination working on those pages is that I needed to save the URL of the filtered page: aka `/blog/welcome-to-kenya` or `/blog/tech`. And this way, we could append the page count number to the end of that: `/blog/welcome-to-kenya/4/` or `/blog/tech/2/`.

After all of that work, I now have a pagination bar that makes me proud of this website. Just add in a few more pretty icons, and I'm satisfied 😁.

<div class="text-center photoswipe-gallery">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/49241327792_e87715127e_o.png"
      thumb_width="400" caption="Pagination bar that can grow with my site"
      full_width="994" full_height="604"
  %}
</div>

---

Haha! You thought the story was over, didn't you? Well... as soon as I merged in my pull request to add the new pagination, I realized something. That paragraph of the installation instructions that I _didn't_ finish? Well, the ending part of it warned that `jekyll-paginate-v2` is _not_ supported by GitHub Pages. This means that when somebody runs the code locally on their computer, they can use `jekyll-paginate-v2` to their hearts' content, and the site will load properly. But GitHub's servers (which normally build the site for me), will not properly execute `jekyll-paginate-v2`, and there's no way to compile the pagination code properly without that.

If I had just _finished_ that section, I could've saved me a whole 30 minutes where the site wasn't broken, and potentially even saved myself a little headache. But at this point, I've come too far to turn back around and go back to my old-fashioned pagination. So, Google came to the rescue.

It turns out (surprise surprise) I'm not the first person to run into this issue. There's a [whole discussion](https://github.com/sverrirs/jekyll-paginate-v2/issues/9) that's going on about this topic, and trying to integrate `jekyll-paginate-v2` with GitHub Pages eventually, but it hasn't made any progress lately. But, I did get some ideas from the discussion. Here are my options of how to proceed:

1. After I finish making any changes to my site, I can commit my new source code to GitHub, bundle the project on my own computer, and then upload the bundled site to a _separate_ branch in GitHub and have GitHub Pages deploy only _that_ branch.
2. I can switch to use the GitHub Pages supported `jekyll-paginate` and let GitHub Pages properly paginate my blog posts.

I started with the second approach. But after some more research, I learned that `jekyll-paginate` doesn't allow for the filtering of tags and collections, which my site was heavily relying on. Therefore, to use `jekyll-paginate` would involve completely redoing my site, and several more hours' work.

Now, I'm not a fan of needing my site to have to be built on a person's computer to work properly. It's never a good idea to have a website's deployment rely on a person's physical computer (which could break, have compilation issues, or generally just not be available). But I figured that other people had run into this issue with `jekyll-paginate-v2` and GitHub Pages, and I'm sure somebody wrote a blog post about it (similarly to like I'm doing now). So I looked up different ways to combat this issue. The blog post I found was [this](https://medium.com/@mcred/supercharge-github-pages-with-jekyll-and-travis-ci-699bc0bde075). I owe my entire pagination to _that blog post_.

Basically what Derek Smart (I wonder if that's his real name 🧐) suggests is to go with the first approach, but don't bundle the project on _your_ machine... use a continuous deployment tool. And here comes Travis CI.

From Travis CI's documentation,
> Continuous Integration is the practice of merging in small code changes frequently - rather than merging in a large change at the end of a development cycle. The goal is to build healthier software by developing and testing in smaller increments. This is where Travis CI comes in.
>
> As a continuous integration platform, Travis CI supports your development process by automatically building and testing code changes, providing immediate feedback on the success of the change. Travis CI can also automate other parts of your development process by managing deployments and notifications.

The ending part of that statement is important:
> Travis CI can... [manage] deployments and notifications.

So, we could (in theory) make a change to the source code in GitHub, and then have Travis CI build my website and "deploy" it to GitHub Pages. And, it turns out my site was already using Travis CI to test the Jekyll build process on every commit to the `gh-pages` branch. So, I only had to add a few lines to have Travis CI _also_ deploy my changes:

```yml
script:
  - JEKYLL_ENV=production bundle exec jekyll build --destination ./site

deploy:
  provider: pages
  local-dir: ./site
  target-branch: gh-pages
  email: deploy@travis-ci.org
  name: Deployment Bot
```

The `script` section asks Travis CI to build the site to the `site` destination directory. The `deploy` section tells Travis CI to run a deploy to the GitHub Pages provider with the `./site` directory, on the target branch `gh-pages`, and which GitHub user to use (in this case, `Deployment Bot` with the email `deploy@travis-ci.org`). There are a few other little pieces to get it working properly, but you can check out my completed [`.travis.yml` file]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/d4c71986f709fd9d341410cf4974ad34424905a6/.travis.yml) if you want to see more. I did need to make a new branch in GitHub—the `release` branch. The idea here is that the `release` branch is used for me to store my source code for this site, and the `gh-pages` branch is for GitHub Pages to deploy. Only the fully compiled and bundled site lives on the `gh-pages` branch.

It's a little complicated, but, one deploy from Travis CI later, and the site was up and running again. _AND_ I had the pagination option of my choosing that had all of the functionality I could ever want.

<div class="text-center photoswipe-gallery">
  {% include elements/photo.html
      url="https://media.giphy.com/media/4xpB3eE00FfBm/giphy.gif"
      thumb_width="400" caption="Success baby gif via Giphy"
      full_width="480" full_height="458"
  %}
</div>

## References

* [github.com: jekyll-paginate-v2, README-GENERATOR](https://github.com/sverrirs/jekyll-paginate-v2/blob/master/README-GENERATOR.md)
* [github.com: jekyll-paginate-v2](https://github.com/sverrirs/jekyll-paginate-v2)
* [stackoverflow.com: when should I use a trailing slash in my URL](https://stackoverflow.com/questions/5948659/when-should-i-use-a-trailing-slash-in-my-url)
* [searchfacts.com: url trailing slash](https://searchfacts.com/url-trailing-slash/)
* [gist.github.com: alialo/2255511](https://gist.github.com/alialo/2255511)
* [medium.com: supercharge github pages with jekyll and travis ci](https://medium.com/@mcred/supercharge-github-pages-with-jekyll-and-travis-ci-699bc0bde075)
* [docs.travis-ci.com: for beginners](https://docs.travis-ci.com/user/for-beginners/)

---

EDIT: Since writing this blog post, my website has switched to using CircleCI, and then to GitHub Actions, for all continuous integration tools. I wrote a blog post [here](/blog/posts/why-i-switched-from-travis-ci-to-circleci/) about why I switched to CircleCI, and wrote another post [here](/blog/posts/why-i-switched-from-circleci-to-github-actions/) about why I again switched to GitHub Actions. I've also moved my default branch to be `main`, instead of `release` and/or `source`. I originally named it `release` because the documentation I was following named it that, but realized later that the name `main` fit my workflow better. Lastly, I've moved my `master` branch to be called `gh-pages`, and I've updated this blog post accordingly.
