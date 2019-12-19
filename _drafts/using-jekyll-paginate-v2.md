---
layout: post
title: Using <header-code>jekyll-paginate-v2</header-code>
tags: [ jekyll, tech ]
draft: true
---

A couple of weeks ago, I started the endeavor of adding Bootstrap to this website. You can read more about how this repository uses Bootstrap, and how to add Bootstrap to a static content site [here](/blog/posts/2019-12-17-adding-bootstrap-to-your-static-content-site/).

But, soon after I started getting an upgrade in my CSS game, I realized that my pagination bar on my blog site was sorely outdated. At one point, I referenced this pagination bar as being beautiful:

<div class="text-center">
  <a data-flickr-embed="true" href="https://www.flickr.com/photos/184539266@N08/48741504061/in/album-72157710863695862/" title="lovely_pagination_bar"><img class="my-image" src="https://live.staticflickr.com/65535/48741504061_7ebbd630fa.jpg" width="450" height="311" alt="Lovely pagination bar"></a>
</div>

But since completely revamping the whole looks of the site, this pagination bar was no longer acceptable. It was old fashioned, wouldn't remember the page you were on if you navigated forward and back in your browser, and didn't have pretty buttons. It was time for me to look into alternate pagination options.

GitHub Pages' built-in pagination suggestion is <a href="https://github.com/jekyll/jekyll-paginate" target="_blank">`jekyll-paginate`</a>. But, it very clearly states that this gem is no longer supported. The recommended newer version of this gem is <a href="https://github.com/sverrirs/jekyll-paginate-v2" target="_blank">`jekyll-paginate-v2`</a>.

I had considered `jekyll-paginate-v2` before, and I briefly mentioned it in <a href="/blog/posts/2019-09-12-adding-pagination-without-jekyll/" target="_blank">this blog post</a>. At that time, I didn't want to make the necessary changes to my directory structure, and I'd have to be willing to either add a trailing `/` to the end of my URLs, or I'd have to be okay with some of my pages having that trailing `/`, and some not to, which I wasn't okay with.

From a technical standpoint, it doesn't really matter to the browser whether you write a `/` on the end of your URL or not; they resolve to the same host. There's more detailed reasons why or why to have a trailing `/` on a URL, but the gist is that the `/` delineates a directory, which then would have files in it: `https://example.com/directory/` and then `https://example.com/directory/file.html`.

In fact, my reading said that although having URLs without `/` is the newer, more popular thing, traditionalists would actually pretty much only have _either_ the trailing `/` _or_ the extension (the `.html` in the above example) in the URL. So if I'm to follow these guidelines, then I probably should add the trailing `/` to the end of all of my URLs except the home page.

I could continue doing research, trying to decide what other pagination options to explore. But I figured that if I wanted to get anything easy done reasonably soon, I'd have to just be okay with compromising on the trailing `/`.

So after admitting that I'd need to accept the trailing `/`, I proceeded to set up `jekyll-paginate-v2` on my repository. How hard could it be?

I started by following the <a href="https://github.com/sverrirs/jekyll-paginate-v2#installation" target="_blank">installation instructions</a>. But, as you'll understand later, I got only got through the second line about updating my `_config.yml` and pages; I never finished that section.

I copy-pasted the basics of the needed configuration into the `_config.yml`, before realizing that although there's lots of documentation in this repo, they never quite clarify that your main `Blog` page needs to be in a `./blog/index.html` file. Furthermore, they never actually say that your blog posts need to be in a `_posts/` directory. Luckily, I poked around the examples enough to figure that out.

Thanks to <a href="https://gist.github.com/alialo/2255511">this gist</a>, I was able to get the basic code of a simple pagination bar going right away. In fact, getting the main `Blog` page paginating wasn't too hard at all!

But, I also wanted to make sure that I could paginate my sub-pages—basically filtering my posts based on tag names and set names. On my site, an example of a tag name is `tech` and an example of a set name is `Welcome to Kenya`. The distinction between the two is that a blog post can have multiple tag names, and they should be one word long. But a blog post can only be a part of one set, and the name can be multiple words with capitalization.

This proved to be a little bit more complicated. The documentation for `jekyll-paginate-v2` describes filtering based on what they call "tags" and "categories". So I started with a single tag, because I wasn't quite sure yet how to deal with the sets. After I added the first bit of code to the tag's filter, I realized that the documentation never properly mentioned in what _directory_ I should put my filter's file. I tried at least four different places I should put it. It wasn't until my last idea when I realized that it had to be placed in the same `blog/` directory as the `index.html`. But, as soon as I moved my tag file into the directory, so it looked like `blog/tag.html`, then it worked miraculously.

It was then easy to move all of the tags to have the same pattern. Moving to the "set", I had more issues, mainly with 1) figuring out the best way to paginate the filtered pages, and 2) `jekyll-paginate-v2` couldn't be formatted to work with filtering a `set` (only `tags`, `categories`, and `locales`, which is languages). So, I had to write my code as if my `set` was a `category` instead. This meant changing several variable names, and in general renaming files and calls to have the word "category" instead of "set". In fact, by the end of the night, I had changed almost every reference to a "set" in the whole codebase.

By the end of the night, I had pretty much decided to just do-away with the whole notion of a "set" versus a "category" and just them all "tags" in the first place. To an end user of this site, they won't really be able to tell the difference anyway. So then, I did a _huge_ find/replace of the word `set` and `category` to just become a tag.

## References
* https://github.com/sverrirs/jekyll-paginate-v2/blob/master/README-GENERATOR.md
* https://github.com/sverrirs/jekyll-paginate-v2
* https://stackoverflow.com/questions/5948659/when-should-i-use-a-trailing-slash-in-my-url
* https://gist.github.com/alialo/2255511
