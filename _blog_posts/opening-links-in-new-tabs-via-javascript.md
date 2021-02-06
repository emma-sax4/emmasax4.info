---
layout: post
title: Opening Links in New Tabs via Javascript
tags: [ tech ]
permalink: /blog/posts/opening-links-in-new-tabs-via-javascript/
date: 2020-01-14 00:00:00 -0600
---

Have you ever noticed that some websites you visit have links that open to new tabs in your browser, and some open to the current tab in your browser? Does that inconsistency confuse or annoy you? Which do you prefer? Do you ever wonder _why_ that is? Well, since the websites of the internet can't quite seem to agree and make a choice, let's discuss how I've approached this topic, and what I've done to make an easy decision about the important question of new tab... or not to new tab.

---

## Introduction

First, let's make sure we're all on the same page when I say "opening in a new tab" versus "opening in the current tab." The first example is of a link opening in the current tab. The second is of a link opening in a new tab:

> This will be a link to <a href="https://github.com/" target="_self">GitHub</a>.
>
> This will be a link to <a href="https://github.com/" target="_blank">GitHub</a>.

Next, for those of you that aren't familiar with Markdown, here's Wikipedia's definition (since Wikipedia is truth 😉):

> Markdown is a lightweight markup language with plain text formatting syntax. Its design allows it to be converted to many output formats, but the original tool by the same name only supports HTML. Markdown is often used to format readme files, for writing messages in online discussion forums, and to create rich text using a plain text editor.

Because Markdown makes it easy to write paragraphs and content, I actually write all of my website's pages and blog posts as Markdown files. [Jekyll](https://jekyllrb.com/) then reads all of my Markdown files and turns them into HTML files (which is what we see on an internet browser).

## Writing Links in Markdown ✍🏼

In Markdown, the easiest way to add a link to a line of text is like this:

```markdown
This will be a link to [GitHub](https://github.com).
```

This example will come out looking like this:

> This will be a link to <a href="https://github.com" target="_self">GitHub</a>.

In this example, the word `GitHub` will be a clickable link to `https://github.com`. And in most Markdown interpreters, including on GitHub, that link will open in the same tab that you're currently in. And if you're like me, this is irritating.

I'm personally in the same boat as [Basia Coulter](https://www.caktusgroup.com/blog/2017/03/01/opening-external-links-same-tab-or-new/) and [@anthony](https://uxmovement.com/navigation/why-external-links-should-open-in-new-tabs/). I believe that all EXTERNAL links should open in a new browser tab, and INTERNAL links should open in the same tab. An EXTERNAL link points to a new website, or a website that has a different URL than the website you are currently on. An INTERNAL link points to the same website that you're currently looking at.

In modern internetting (not a real word, but I think I might copyright it), it's totally a good idea to be linking all over the place. The more links the better—within reason of course. And if you're opening all of the external links in the same tab that the user is looking in, that user will be hitting the `Back` button _a lot_. Even I get tired of that much `Back` buttoning.

## Writing Links in Markdown that Open in a New Tab ⎘

So, I endeavored to find the best way to set my Markdown links to open in new tabs. By default, in Markdown with [kramdown](https://kramdown.gettalong.org/) (my selected Markdown-to-HTML converter), there's only two ways to make this happen:

1. This option is essentially injecting raw HTML into the Markdown sentence. While this is totally acceptable and it works, it's typing a lot of special characters into a sentence, just for a link to open in a new tab. This solution works when Markdown is interpreted with kramdown, and it will render properly on GitHub, although GitHub will still open the link in the same tab.

    ```html
    This will be a link to <a href="https://github.com" target="_blank">GitHub</a>.
    ```

2. This option is what kramdown provides as a way to open links in new tabs. It isn't as awful to type, and it's not quite as many extra characters. However, it will not render on GitHub nicely at all. When rendered on GitHub, it will leave the `{:target="_blank"}` as part of the text sentence, meaning it's disrupting the read of the document _and_ confusing readers.

    ```markdown
    This will be a link to [GitHub](https://github.com){:target="_blank"}.
    ```

And with either of the solutions, GitHub does this weird raw text italisizing that makes looking at these files very painful. Here's an example. Do you see how half of the paragraphs have been entirely italisized?

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/49386386903_198f4cc1e2_b.jpg"
      thumb_width="400" title="GitHub's weird italisizing" lightbox="Opening tabs"
  %}
</div>

So, neither of these options are perfect, and I don't like either of them. I want to be able to easily type a link, with the traditional Markdown format (`[link](url)`), and I want the link to open in a new tab on the browser (converted to HTML from kramdown), and to read in GitHub properly (not include the `{:target="_blank"}`).

## A Not-So Terrible Solution 🤞🏼

After several pull requests of me changing my mind about how to write links, and doing massive search-replaces in my codebase, I found a different kind of solution... a solution that involves Javascript. Static sites (like mine) can use Javascript to do view-based logic and methods right in front of the user. It's unwise to incorporate _a lot_ of Javascript on a single page because it'll slow down loading and operation times, but it's how I did simply functionality, like showing the comments on the bottom of each page or loading the Feather icons. And so of course, somebody has written [this blog post](https://html.com/attributes/a-target/) which nicely provides a Javascript solution for opening every external URL in a new tab. This script is what is suggested to be placed at the bottom of our HTML files:

```html
{% raw %}<script type="text/javascript">
  function externalLinks() {
    for(var c = document.getElementsByTagName('a'), a = 0; a < c.length; a++) {
      var b = c[a];
      b.getAttribute('href') && b.hostname !== location.hostname && (b.target = '_blank')
    }
  };
  externalLinks();
</script>{% endraw %}
```

It's very simple, but yet, it covers almost exactly what I need. On every page that's loaded, it will go through my converted and compiled HTML, find each attribute that contains a link, and will guarantee that each EXTERNAL link will open to a new tab, and that each INTERNAL link opens to the current tab. Voilà!

But there's one piece missing. That's for exceptions. Every now and then—such as writing this blog post—I want an EXTERNAL link that will open in the current tab. So, I need a way to exclude those few links from opening in a new tab. The answer comes from changing the `for` loop to look like this:

```javascript
var links = document.getElementsByTagName('a');

for(counter = 0; counter < c.length; counter++) {
  var link = links[counter];

  if (link.target == '_self') {
    link.getAttribute('href') && link.hostname !== location.hostname && (link.target = '_self');
  } else {
    link.getAttribute('href') && link.hostname !== location.hostname && (link.target = '_blank');
  };
};
```

So, if the link in Markdown is written explicitly requesting the `target="_self"`, then honor that. So the following link would open in the current tab:

```markdown
This will be a link to <a href="https://github.com/" target="_self">GitHub</a>.
```

Similarly, if a link is explicitly written with `target="_blank"`, no matter whether external or internal, the link should always open that in a new tab. If nothing is set for the `target` at all, then open in a new tab _if_ the link is external.

## Putting It All Together 🧩

Here's what my new script looks like with [html.com](https://html.com/)'s suggestion and my edits:

```html
{% raw %}<!--
To open an EXTERNAL link in the CURRENT tab, write your link like this:
  <a href="https://github.com" target="_self">GitHub</a>

To open an INTERNAL link in a NEW tab, write your link like this:
  <a href="https://{{ site.domain }}" target="_blank">My website</a>
-->
<script type="text/javascript">
  function openExternalLinksInNewTabs() {
    var links = document.getElementsByTagName('a');

    for(counter = 0; counter < c.length; counter++) {
      var link = links[counter];

      if (link.target == '_self') {
        link.getAttribute('href') && link.hostname !== location.hostname && (link.target = '_self');
      } else {
        link.getAttribute('href') && link.hostname !== location.hostname && (link.target = '_blank');
      };
    };
  };
  openExternalLinksInNewTabs();
</script>{% endraw %}
```

Now this _**really**_ does everything I need. 🙌🏼

## References

* [wikipedia.com: Markdown](https://en.wikipedia.org/wiki/Markdown)
* [jekyllrb.com](https://jekyllrb.com/)
* [kramdown](https://kramdown.gettalong.org/)
* [html.com: a Target](https://html.com/attributes/a-target/)
* [caktusgroup.com: Opening External Links Same Tab or New](https://www.caktusgroup.com/blog/2017/03/01/opening-external-links-same-tab-or-new/)
* [uxmovement.com: Why External Links Should Open in New Tabs](https://uxmovement.com/navigation/why-external-links-should-open-in-new-tabs/)
