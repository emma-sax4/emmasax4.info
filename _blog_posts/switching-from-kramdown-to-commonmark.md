---
layout: post
title: Switching from kramdown to CommonMark
tags: [ tech, jekyll ]
permalink: /blog/posts/switching-from-kramdown-to-commonmark/
date: 2020-07-19 10:00:33 -0500
---

* [Introduction](#introduction)
* [Adding <header-code>jekyll-commonmark</header-code>](#adding-jekyll-commonmark)
* [Debugging 🕷](#debugging)
* [Conclusion](#conclusion)
* [References](#references)

<div id="anchor">
  <a id="introduction">&nbsp;</a>
</div>

## Introduction

Up until a few weeks ago, my website (this website) had always used [kramdown](https://kramdown.gettalong.org/) (the lowercase "k" is intentional). GitHub Pages (where my website is hosted) by default uses kramdown, so I kept it that way even as I moved my site to being built on [Travis CI](https://docs.travis-ci.com/user/for-beginners/), and eventually [CircleCI](https://circleci.com/), before finally landing on [GitHub Actions](https://docs.github.com/en/actions).

And over time, as I continued to add more content to this site, building the HTML website started to get slower and slower to load. When I started using Travis CI to build my application, running `bundle exec jekyll build` was maybe taking about 2 minutes of computation time. By the time it go over to CircleCI, it was taking a little bit longer. I don't think the platform I was running it on mattered... rather my project continued to grow. And my first official build on GitHub Actions took 2.606 seconds.

When that happened, I hadn't yet introduced my [LEGO page](/interests-and-hobbies/legos/). And when I did finally build my LEGO page, suddenly, the build time of my website skyrocketed. Using two different collections (blog posts and LEGOs) and looping over both makes the build time of my site _much_ higher than it was before. Add in a few more blog posts, and my site was taking between 4 and 5 seconds to load locally.

The amount of time my site takes to build on its CI tool doesn't particularly matter to me... a few seconds don't make a difference. What was almost painful was working locally. When I'm working locally on my computer, every time I make a small change to a file, Jekyll would reload my site. And waiting 5 seconds after adding one comma was pushing my patience.

So, when I came across the [jekyll/jekyll-commonmark](https://github.com/jekyll/jekyll-commonmark) gem, I was curious. It advertises a Markdown parser that is faster than kramdown. The reason it's faster is because it uses a C compiler instead of a Ruby compiler (see [here](https://jekyllrb.com/docs/configuration/markdown/)). Normally I'm kind of a Ruby-lover, but I will admit that it's not the fastest language around. So, I thought I may as well try it out on a pull request. If it's too many changes, or it doesn't actually benefit me, then no need to switch; kramdown is getting most of what I want done.

<div id="anchor">
  <a id="adding-jekyll-commonmark">&nbsp;</a>
</div>

## Adding <header-code>jekyll-commonmark</header-code>

Things started out easy. I added this to my `Gemfile`:

```ruby
gem 'jekyll-commonmark', '~> 1.3'
```

And I ran `bundle install`. Things installed nicely, and I was up and rolling.

Next I had to indicate to Jekyll to use CommonMark instead of kramdown. I deleted this:

```yml
markdown: kramdown
```

and added this:

```yml
markdown: CommonMark
commonmark:
  options:
    - SMART
    - UNSAFE
  extensions:
    - autolink
    - table
```

I selected the `options` and `extensions` to use based on [this documentation](https://github.com/jekyll/jekyll-commonmark#configuration), and chose each one specifically based off of my needs as I debugged the switch.

<div id="anchor">
  <a id="debugging">&nbsp;</a>
</div>

## Debugging 🕷

The very first thing I noticed when I first ran `jekyll build` was that CommonMark was much faster. My build went from about 5 seconds locally to 2 seconds, all from switching to CommonMark. A blogger could get spoiled with build times that fast!

And then I took a look at the results. The first thing I noticed was that none of my Markdown showed up! My immediate thought was that CommonMark isn't going to work if my content doesn't show up. But lo-and-behold, the answer was simple... remove every use of `markdownify` in my entire site. To be completely honest, I'm not sure what `markdownify` is for, but somehow it previously indicated to kramdown to process a string as Markdown. I guess CommonMark didn't like that.

The only other issue I noticed was that CommonMark doesn't have an easy Table of Contents feature. This is rather surprising, given the amount of blogs that use CommonMark. This is how I defined a Table of Contents with kramdown:

```
* Table of Contents
{:toc}
```

Nice and easy. But apparently that's kramdown specific, and the only way to define a Table of Contents in CommonMark is to do it the old-fashioned way (sort of similar to the GitHub Markdown way):

```
* [Header One](#header-one)
* [Header Two](#header-two)
  * [Nested Header One](#nested-header-one)
  * [Nested Header Two](#nested-header-two)
* [Header Three](#header-three)
  * [Nested Header One](#nested-header-one-2)
```

Now, if I'm completely honest, this isn't that bad. It's terrible to have to update, but if I wait until the blog post is written, then it won't go through lots more changes. Especially when I found [this Ruby file](https://github.com/emmasax4/emmasax4.info/blob/main/scripts/toc_markdown.rb) and fixed it up to suit my needs... it makes it easy to generate a Table of Contents based off of existing headers in a particular file.

The challenging part was setting the anchors. When I used kramdown's TOC, the anchors were automatic (because I actually moved my navigation bar to be sticky, they actually had a slight bug in them the whole time, but that's unrelated). Now, it was time for me to have to set my own anchors on my headers—adding to the amount of "annoying" that is having to update a TOC. This was the ending solution:

```html
{% raw %}<div id="anchor">
  <a id="header-two">&nbsp;</a>
</div>

## Header Two{% endraw %}
```

The first line indicates that this is an anchor, and the `id="anchor"` calls the CSS class that I added. Because my navigation bar is now sticky, I need my anchor to line up with the _bottom_ of the top navigation bar, versus the _top_ of the entire window. Without the second line, whenever a user clicked on a TOC link, it would slightly cut off the words of the anchor... not a very good user experience! So the second line actually makes an empty line `&nbsp;` the anchor. And the last line actually prints the words of the header, for users to see. With this, the actual anchor lines up with the top of the window, but to the user, it looks like it's lining up with the bottom of the top nav bar. There were several links I used as research for this, and I'll link to all of them below.

And then, the last trick was to add CSS:

```css
#anchor {
  position: relative;
}

#anchor a {
  position: absolute;
  top: -60px;
}
```

I'm not exactly sure why `#anchor` defines the `position` as `relative`, and the `#anchor a` defines the `position` as `absolute`, but by a miracle, I got this to work, and I'm not going to question it now!

Here's what my anchor looked like in the beginning:

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/50120866658_714fff8d24_o.png"
      thumb_width="400" title="With the anchors misaligned" lightbox="kramdown to CommonMark"
  %}
</div>

And here's my anchors at the end:

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/50121433291_c532150c4a_o.png"
      thumb_width="400" title="With the anchors properly lined up" lightbox="kramdown to CommonMark"
  %}
</div>

<!-- The last big issue was that my LEGO page was completely empty! All of my LEGOs were gone. After doing some googling, I realized that CommonMark does have support for the `<details></details>` HTML, which my LEGO pages were using, but CommonMark somehow wasn't picking up the tags as HTML. The solution? move them back in indentation, so that this:

```html
{% raw %}  {% for lego in lego_list %}
    <details>
      <summary style="font-size: 32px; margin-bottom: 10px;">{{ lego.title }}</summary>
      {{ lego.content }}
    </details>
  {% endfor %}{% endraw %}
```

becomes this:

```html
{% raw %}  {% for lego in lego_list %}

<details>
  <summary style="font-size: 32px; margin-bottom: 10px;">{{ lego.title }}</summary>
  {{ lego.content }}
</details>

  {% endfor %}{% endraw %}
```

It certainly doesn't look as pretty... I always prefer to have my HTML indented properly. But compromising and being willing to move my lines around is worth a much faster build time. -->

After I was satisfied with my changes, I willingly merged my pull request and deployed away. A little while later, I noticed a few other key pieces I missed.

First, my syntax highlighting also broke, and I didn't even notice for several weeks! Here's an image of how the HTML changed during the switch:

<div class="text-center">
  {% include elements/photo.html
    url="https://user-images.githubusercontent.com/7562793/87866750-f695d980-c94a-11ea-87e1-9fc8c5e56d88.png"
    thumb_width="400" title="HTML without syntax highlighting"
    lightbox="kramdown to CommonMark"
  %}
</div>

In fact, when I originally saw this, I probably thought the HTML looked cleaner after the switch. But in reality, the switch caused all of my syntax highlighting to break.

It turns out the solution was simple: pull `jekyll-commonmark` from the GitHub source directly... the [pull request](https://github.com/jekyll/jekyll-commonmark/pull/29) that introduces syntax highlighting was merged over a year ago, but was never officially released on Rubygems.

```ruby
gem 'jekyll-commonmark', git: 'https://github.com/jekyll/jekyll-commonmark.git', ref: '6b6c9a'
```

The very last thing I needed to add was that CommonMark needs directories specifically `exclude`d in the `_config.yml`. I'm not entirely sure _why_ this is, but without it, CommonMark adds a bunch of development directories to finished built site. This means that the public (ignoring my public GitHub repository) could, in theory, potentially access all of these directories and files, which is not good. Here's the blurb I added to my `_config.yml`:

```yml
exclude:
  - scripts
  - vendor
  - Gemfile
  - Gemfile.lock
```

<div id="anchor">
  <a id="conclusion">&nbsp;</a>
</div>

## Conclusion

Most of these changes only took a few of hours, and in my opinion, they were well worth the time. In about 120 local builds, I'll have made up the time that I would've spent waiting for my site to build. In writing this blog post alone, I've already done about 40 local builds. And the changes reflected on GitHub Actions? The last build with kramdown took **3.796 seconds** to build. My first build with CommonMark took **1.794 seconds**... just a smidgen over 2 seconds faster.

<div id="anchor">
  <a id="references">&nbsp;</a>
</div>

## References

* [sitepoint.com: fixed nav with positioning](https://www.sitepoint.com/community/t/fixed-nav-with-positioning/290073/4)
* [caktusgroup.com: css tip fixed headers and section anchors](https://www.caktusgroup.com/blog/2017/10/23/css-tip-fixed-headers-and-section-anchors/)
* [stackoverflow.com: fixed page header overlaps in page anchors](https://stackoverflow.com/questions/4086107/fixed-page-header-overlaps-in-page-anchors)
* [codepen.io: anchor examples](https://codepen.io/Paulie-D/pen/zvkpJ/)
* [wordpress.org: heading with anchor links are covered up by top of page header](https://wordpress.org/support/topic/heading-with-anchor-links-are-covered-up-by-top-of-page-header/)
* [github.com: jekyll/jekyll-commonmark](https://github.com/jekyll/jekyll-commonmark)
* [github.com: gjtorikian/commonmarker](https://github.com/gjtorikian/commonmarker)
