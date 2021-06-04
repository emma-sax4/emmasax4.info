---
layout: post
title: Adding Lightbox to a Jekyll Website
tags: [ tech, jekyll ]
permalink: /blog/posts/adding-lightbox-to-a-jekyll-website/
date: 2020-08-23 23:05:00 -0500
---

In July, as I worked on adding more LEGO entries to my [LEGO page](/interests-and-hobbies/lego/), I realized something. I was adding a _lot_ of pictures. And over time, I'd slowly be adding more. And images, unless you make them really tiny, take up a lot of precious screen space, requiring users to scroll a lot more to bypass lists of pictures. And if they're not zoommable, what does somebody do when they want to take a closer look?

So, the answer to my questions was, to make pictures zoommable, and then show a thumbnail on the general page. This way, the image a user sees on the page is tinier (think 200 pixels wide), and then when they click it, it becomes full-screen (perhaps around 600 pixels wide).

So from a preliminary Google search, I realized what I needed was fancy Javascript/CSS to make this happen. I found the [Lightbox](https://lokeshdhakar.com/projects/lightbox2/) solution pretty early on into my searching, and it looked so professional that I realized that I needed to give this a go.

Check out a tiny demo of what Lightbox looks like in action:

<div class="text-center">
  <h4>Without Lightbox:</h4>
  <img class="image" src="https://i.imgur.com/lyWrj3r.jpeg" width="400" alt="Adorable creature">
  <br><br>
  <h4>With Lightbox (click the picture):</h4>
  {% include elements/photo.html
      url="https://i.imgur.com/lyWrj3r.jpeg" type="lightbox2"
      thumb_width="200" caption="Adorable creature" lightbox_gallery="PHOTO1"
  %}
</div>

Implementing Lightbox _seemed_ simple. Copy-paste a [CSS file](https://github.com/lokesh/lightbox2/tree/dev/dist/css), a [Javascript file](https://github.com/lokesh/lightbox2/tree/dev/dist/js), and add [four images](https://github.com/lokesh/lightbox2/tree/dev/dist/images) to your project. And then call them from your `<head>` and as a `<script>`:

```html
{% raw %}<link rel="stylesheet" href="/assets/css/lightbox.min.css">{% endraw %}
```

and

```html
{% raw %}<script src="/assets/js/lightbox.min.js"></script>{% endraw %}
```

And then just call your image with a `data-lightbox` element:

```html
{% raw %}<a href="https://example-image.com" title="Example image goes here" data-lightbox="IMAGE-1">
  <img class="image" src="https://example-image.com" width="200" alt="Example image goes here">
</a>{% endraw %}
```

But, I quickly ran into issues where the images wouldn't get bigger on-click. To understand what I mean by the images not getting bigger, check out the official demo [here](https://lokeshdhakar.com/projects/lightbox2/) or try to imagine my cute picture from above in its smaller form, but not getting bigger when you click on it. The photo is supposed to grow to full-size upon click, allowing a user to see even a small image more clearly.

Well, the solution was that my version of Jquery was outdated. The [Getting Started](https://lokeshdhakar.com/projects/lightbox2/#getting-started) notes tell us that we must use 1.7+ version of Jquery and it doesn't support the `slim` builds, so my Jquery was broken in two ways—apparently I missed that in my set up. So I ended up just taking Lokesh's version of Jquery and Sizzle, and replacing my Jquery with those. There's also a note which states the order that the JS files are loaded matters, and of course I had about 10 minutes of struggling while I learned that on my own.

The only pieces that I eventually customized was the fonts I wanted the captions to use, the `resizeDuration` to `500` instead of `700` so that my images would load a bit faster, and the `disableScrolling` to `true` instead of `false` to prevent scrolling while the images are open. Both of those two values I set directly inside my JS file, and the font change was set directly in my CSS file. The final CSS and Javascript files I use are available [here]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/67e0b5c477ca8fed72f4fc2a364e4eb47af759ab/assets/css/lightbox.min.css) and [here]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/8aec2dd10f0397ea25e7f6843126bcc3f58cee3a/assets/js/lightbox.min.js) respectively.

In order to make the use of Lightbox a little bit more Jekyll friendly, I realized that I didn't really want to be copy-pasting a bunch of HTML code all over the place. What I wanted was a single "method" that could be reused. Although there isn't an easy solution for this in Liquid/Jekyll, what I decided on was an `_includes` file:

```html
{% raw %}<a href="{{ include.url }}" caption="{{ include.title }}" data-lightbox="{{ include.lightbox }}">
  <img class="image" src="{{ include.url }}" width="{{ include.thumb_width }}" alt="{{ include.title }}">
</a>{% endraw %}
```

And then, we can call it like this:

```html
{% raw %}{% include elements/photo.html url="https://example-photo.com" thumb_width="150"
                               caption="Title of example photo" lightbox_gallery="PHOTO-1"
%}{% endraw %}
```

Note the `lightbox` property is for grouping sets of photos together on a page (particularly handy on pages like my [LEGO page](/interests-and-hobbies/lego/) where there's multiple sets of photos all on one HTML page).

And voila! There's still some copy-pasting, but it's a little easier than copy-pasting a bunch of repetitive HTML (which calls the URL twice, the title twice, etc).

After the first few hours of installation pain (which could've been greatly eased if I read _all_ of the instructions before beginning), Lightbox has been flawless ever since. It's worked well for everything I've used it for, and I can't imagine going back. All of my photos look so much more professional now, both on larger screens and on mobile.
