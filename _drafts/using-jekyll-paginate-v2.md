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

I could continue doing research, trying to decide what pagination options to explore, but I figured that if I wanted to get anything easy done soon, I'd have to just be okay with compromising on the trailing `/`.
