---
layout: post
title: Turning Lightbox2 into PhotoSwipe
tags: [ tech, jekyll ]
permalink: /blog/posts/turning-lightbox2-into-photoswipe/
date: 2021-06-14 12:00:00 -0500
---

In August of 2020, I made a big push to add better photo functionality to my website. I added [Lightbox2](https://lokeshdhakar.com/projects/lightbox2/), by @lokesh, to my site. In a [previous blog post](/blog/posts/adding-lightbox-to-a-jekyll-website/), I referenced it as plain Lightbox. It turns out that Lightbox2 is built upon Lightbox JS, by the same author. But technically, I incorporated Lightbox2.

But recently, upon the advice of an old schoolmate, I came across [PhotoSwipe](https://photoswipe.com/). PhotoSwipe provides similar abilities to Lightbox2, but also provides zooming, faster loading, and swipe actions, as well as clicking and arrow key pressing. This is a definite benefit for viewing my site on mobile.

The author of PhotoSwipe, @dimsemenov, has been working on a new v5 beta version of PhotoSwipe, which is [documented here](https://photoswipe.com/v5/docs/getting-started/). Although the v5 documentation isn't fully fleshed out (the version is still in beta after all) I still found PhotoSwipe v5 simple enough to set up.

I started with an `assets/js/activate_photoswipe.js` file:

```javascript
import PhotoSwipeLightbox from './photoswipe-lightbox.esm.min.js'

const options = {
  gallerySelector: '.photoswipe-gallery',
  childSelector: '.photoswipe',
  pswpModule: '/assets/js/photoswipe.esm.min.js',
  pswpCSS: '/assets/css/photoswipe.min.css'
}

const lightbox = new PhotoSwipeLightbox(options)
lightbox.init()
```

And then I modified my `_includes/photo.html` file to allow both Lightbox2 photos and PhotoSwipe:

```html
{% raw %}{% if include.type == "lightbox2" %}
  <a class="lightbox2 photo" href="{{ include.url }}" data-lightbox="{{ include.lightbox_gallery }}" title="{{ include.caption }}">
{% else %}
  <a class="photoswipe photo" href="{{ include.url }}" target="_blank" data-pswp-width="{{ include.full_width }}" data-pswp-height="{{ include.full_height }}">
{% endif %}

    <img class="image" src="{{ include.url }}" width="{{ include.thumb_width }}" height="{{ include.thumb_height }}" alt="{{ include.alt }}">
  </a>{% endraw %}
```

This way, when we call a photo, we can pass in a `type` (only required if using Lightbox2). And if we're using Lightbox2, then create a Lightbox2 photo, else create a PhotoSwipe photo. Here's how I would call the `_includes` file:

```html
<!-- Lightbox2 -->
{% raw %}{% include elements/photo.html
   url="https://i.imgur.com/lyWrj3r.jpeg"
   thumb_width="200" caption="Adorable creature" alt="Adorable creature"
   type="lightbox2" lightbox_gallery="PHOTO1"
%}{% endraw %}

<!-- PhotoSwipe -->
{% raw %}<div class="photoswipe-gallery">
  {% include elements/photo.html
     url="https://i.imgur.com/lyWrj3r.jpeg"
     thumb_width="200" alt="Adorable creature"
     full_width="600" full_height="380"
  %}
</div>{% endraw %}
```

Then, in my `_layouts/default.html` file, I needed to initialize PhotoSwipe:

```html
<script src="/assets/js/activate_photoswipe.js" type="module"></script>
```

Lastly, I needed to download three files from the [`dist`](https://github.com/dimsemenov/PhotoSwipe/tree/v5-beta/dist) directory: `photoswipe.css`, `photoswipe-lightbox.esm.min.js`, and `photoswipe.esm.min.js`. I placed these in `assets/css` and `assets/js` according to the file types.

And voilà. PhotoSwipe works! Feel free to compare a Lightbox2 example (left) with a PhotoSwipe example (right):

<div class="text-center photoswipe-gallery">
  {% include elements/photo.html
      url="https://i.imgur.com/lyWrj3r.jpeg"
      thumb_height="127" caption="Adorable creature"
      type="lightbox2" lightbox_gallery="PHOTO1"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/lyWrj3r.jpeg"
      thumb_height="127" alt="Adorable creature"
      full_width="600" full_height="380"
  %}
</div>

As you can see, the two are very similar. However, PhotoSwipe is slightly faster to load, and I've found that Lightbox2 is touchy to use (aka not a consistent user experience).

But the real benefit to PhotoSwipe is visible when you have a gallery of images. Take a look at this Lightbox2 gallery below:

<div class="text-center">
  {% include elements/photo.html
      url="https://i.imgur.com/lyWrj3r.jpeg"
      thumb_height="127" caption="Original adorable creature"
      type="lightbox2" lightbox_gallery="lightbox-gallery"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/ZusTRJ9.jpg"
      thumb_height="127" caption="Kitten cuddling a puppy"
      type="lightbox2" lightbox_gallery="lightbox-gallery"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/NuhaJCb.jpeg"
      thumb_height="127" caption="Puppy popping bubbles"
      type="lightbox2" lightbox_gallery="lightbox-gallery"
  %}
</div>

The images are slow to load, and although you can navigate by clicking a photo and using arrow keys on keyboard, a mobile user cannot swipe. Furthermore, if you click in _slightly_ the wrong place, a Lightbox2 gallery will exit, making it a tedious viewing experience.

But, take a look at the same gallery through PhotoSwipe:

<div class="text-center photoswipe-gallery">
  {% include elements/photo.html
      url="https://i.imgur.com/lyWrj3r.jpeg"
      thumb_height="127" alt="Original adorable creature"
      full_width="600" full_height="380"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/ZusTRJ9.jpg"
      thumb_height="127" alt="Kitten cuddling a puppy"
      full_width="600" full_height="450"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/NuhaJCb.jpeg"
      thumb_height="127" alt="Puppy popping bubbles"
      full_width="530" full_height="424"
  %}
</div>

Hopefully the images are loading faster, you can swipe through photos (helpful when you're a mobile user), and zoom may even be available (I've noticed zoom is only available on some images, and the images in this demo may not offer zoom... perhaps future versions of PhotoSwipe may increase zoom capabilities).

Now with only those few changes, PhotoSwipe v5 is completely set up, and I can begin transitioning my Lightbox2 photos to PhotoSwipe. The most irritating process of that transition was that PhotoSwipe requires the HTML to specifically provide the width and height of each picture by pixel. So, I needed to look at each picture individually, and look up its width and height. Good thing I only had 194 pictures shown throughout my entire site&nbsp;🥴.

But even after all that, you'll notice that there's something huge missing from PhotoSwipe: captions. All of my Lightbox2 photos had captions. Luckily, PhotoSwipe v5 has some detailed documentation on how to enable captions.

First, I added Javascript to `assets/js/activate_photoswipe.js`. Based on the documentation provided, and after some fiddling on my part, the entire file came out like this:

```javascript
import PhotoSwipeLightbox from './photoswipe-lightbox.esm.min.js'

const options = {
  gallerySelector: '.photoswipe-gallery',
  childSelector: '.photoswipe',
  pswpModule: '/assets/js/photoswipe.esm.min.js',
  pswpCSS: '/assets/css/photoswipe.min.css'
}

const lightbox = new PhotoSwipeLightbox(options)

lightbox.on('uiRegister', function () {
  lightbox.pswp.ui.registerElement({
    name: 'custom-caption',
    order: 9,
    isButton: false,
    appendTo: 'root',
    html: 'Caption Text',
    onInit: (el, pswp) => {
      lightbox.pswp.on('change', () => {
        const currentSlideElement = lightbox.pswp.currSlide.data.element
        const hiddenCaption = currentSlideElement.querySelector('.caption')
        const customCaptionElements = document.getElementsByClassName('pswp__custom-caption')
        let captionHTML = ''

        if (hiddenCaption === '' || hiddenCaption === null) {
          for (let counter = 0; counter < customCaptionElements.length; counter++) {
            customCaptionElements[counter].classList.add('invisible')
          }
        } else {
          for (let counter = 0; counter < customCaptionElements.length; counter++) {
            customCaptionElements[counter].classList.remove('invisible')
          }

          if (currentSlideElement) {
            captionHTML = hiddenCaption.innerHTML
          }
        }

        el.innerHTML = captionHTML
      })
    }
  })
})

lightbox.init()
```

What this logic does is when we click on a photo, if the `caption` class is either missing or empty, then it'll turn all PhotoSwipe captions "invisible" by adding the `invisible` class. If the `caption` class exists and the caption contains words, then it'll remove any `invisible` class, and set the caption text to match the HTML text provided. This way, photos can have optional captions, and if the caption doesn't exist, then the spot for a caption will disappear. If an ["alt"](https://www.w3schools.com/tags/att_img_alt.asp) is provided, then use that as alternative text, but don't automatically use it as a caption. If _only_ a caption is given, then we can _also_ use that as alternative text. See a gallery example below:

<div class="text-center photoswipe-gallery">
  {% include elements/photo.html
      url="https://i.imgur.com/lyWrj3r.jpeg"
      thumb_height="127" caption="Original adorable creature"
      full_width="600" full_height="380"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/ZusTRJ9.jpg"
      thumb_height="127" alt="Kitten cuddling a puppy"
      full_width="600" full_height="450"
  %}
  {% include elements/photo.html
      url="https://i.imgur.com/NuhaJCb.jpeg"
      thumb_height="127" caption="Puppy popping bubbles"
      full_width="530" full_height="424"
  %}
</div>

Throughout my PhotoSwipe experimenting, there were several other changes I made to the core files mentioned. These were in order to implement nested galleries, caption and "alt" interchangeability, optional thumb photo widths and heights, etc. In order to avoid attempting to summarize further with English language, I'll just provide links to the completed code:

* [Documentation about adding PhotoSwipe and Lightbox2]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/b6661ecdf093cf79dbb755f15eabab1740c75390/.github/contributing.md#images)
* [`assets/js/activate_photoswipe.js`]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/b6661ecdf093cf79dbb755f15eabab1740c75390/assets/js/activate_photoswipe.js)
* [`_includes/elements/photo.html`]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/b6661ecdf093cf79dbb755f15eabab1740c75390/_includes/elements/photo.html)
* [`_layouts/default.html`]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/b6661ecdf093cf79dbb755f15eabab1740c75390/_layouts/default.html#L58-L64)

Please feel free to reach out to me for additional information or questions you have about implementing PhotoSwipe v5. With PhotoSwipe, I'm confident that viewing images on my website will be a much better experience for both me and my viewers going forward.
