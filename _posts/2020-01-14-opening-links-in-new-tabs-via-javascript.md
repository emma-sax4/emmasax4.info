---
layout: post
title: Opening Links in New Tabs via Javascript
tags: [ tech ] # optional
draft: true
---

For those of you that aren't familiar with Markdown, here's Wikipedia's definition (since Wikipedia is truth 😉):
> Markdown is a lightweight markup language with plain text formatting syntax. Its design allows it to be converted to many output formats, but the original tool by the same name only supports HTML. Markdown is often used to format readme files, for writing messages in online discussion forums, and to create rich text using a plain text editor.

Because Markdown makes it easy to write paragraphs and content, I actually write all of my website's pages and blog posts as Markdown files. [Jekyll](https://jekyllrb.com/) then reads all of my Markdown files and turns them into HTML files (which is what we see on an internet browser).

In Markdown, the easiest way to add a link to line of text is like this:
```markdown
This will be a link to [HelloWorld](https://helloworld.com/).
```
So in this example, the word `HelloWorld` will be a clickable link to `https://helloworld.com/`. And in most Markdown interpreters, including on GitHub, that link will open in the same tab that you're currently in. And if you're like me, this is irritating.

I'm personally in the same boat as [Basia Coulter](https://www.caktusgroup.com/blog/2017/03/01/opening-external-links-same-tab-or-new/) and [@anthony](https://uxmovement.com/navigation/why-external-links-should-open-in-new-tabs/). I believe that all EXTERNAL links should open in a new browser tab, and all INTERNAL links should open in the same tab. An EXTERNAL link points to a new website, or a website that has a different URL than the website you are currently on. An INTERNAL link points to the same website that you're currently looking at.

In modern internetting (not a real word, but I think I might copyright it), it's totally a good idea to be linking all over the place. The more links the better—within reason of course. And if you're opening all of the external links in the same tab that the user is looking in, that user will be hitting the `Back` button _a lot_. Even I get tired of that much `Back` buttoning.

So, I endeavored to find the best way to set my Markdown links to open in new tabs. By default, in Markdown with [kramdown](https://kramdown.gettalong.org/) (my selected Markdown-to-HTML converter), there's only two ways to make this happen:
1. This option is essentially injecting raw HTML into the Markdown sentence. While this is totally acceptable and it works, it's typing a lot of special characters into a sentence, just for a link to open in a new tab. This solution works when Markdown is interpreted with kramdown, and it will render properly on GitHub (although GitHub will still open the link in the same tab).
    ```html
    This will be a link to <a href="https://helloworld.com/" target="_blank">HelloWorld</a>.
    ```
2. This option is what kramdown provides as a way to open links in new tabs. It isn't as awful to type, and it's not quite as many extra characters. However, it will not render on GitHub nicely at all. When rendered on GitHub, it will leave the `{:target="_blank"}` as part of the text sentence, meaning it's disrupting the read of the document _and_ confusing readers.
    ```markdown
    This will be a link to [HelloWorld](https://helloworld.com/){:target="_blank"}.
    ```
And with either of the solutions, GitHub does this weird raw text italisizing that makes looking at these files very painful. Here's an example. Do you see how half of the paragraphs have been entirely italisized?

<div class="text-center">
  <a data-flickr-embed="true" href="https://www.flickr.com/photos/184539266@N08/49386386903/in/album-72157710863695862/" title="GitHub&#x27;s weird italisizing"><img class="my-image" src="https://live.staticflickr.com/65535/49386386903_198f4cc1e2_z.jpg" width="986" height="962" alt="GitHub&#x27;s weird italisizing"></a>
</div>

So, neither of these options are perfect, and I don't like either of them. I want to be able to easily type a link, with the traditional Markdown format (`[link](url)`), and I want the link to open in a new tab on my website (converted to HTML from kramdown), and to read in GitHub properly (not include the `{:target="_blank"}`).

And here's where Javascript comes in. Static sites (like mine) can use Javascript to do view-based logic and methods right in front of the user. It's unwise to incorporate _a lot_ of Javascript on a single page because it'll start slowing down loading and operation times, but it's how I did simply functionality, like showing the comments on the bottom of each page, loading the Feather icons, etc. And so of course, somebody has written [this blog post](https://html.com/attributes/a-target/) which nicely provides a Javascript solution for opening every external URL in a new tab. The final solution looks like this:
```javascript
<script type="text/javascript">
  function externalLinks() {
    for(var c = document.getElementsByTagName('a'), a = 0; a < c.length; a++) {
      var b = c[a];
      b.getAttribute('href') && b.hostname !== location.hostname && (b.target = '_blank')
    }
  };
  externalLinks();
</script>
```

It's very simple, but yet, it covers exactly what I need. On every page that's loaded, it will go through my converted and compiled HTML, find each attribute that contains a link, and will guarantee that each EXTERNAL link will open to a new tab, and that each INTERNAL link opens to the current tab. Voilà!

## References

* [wikipedia.com: Markdown](https://en.wikipedia.org/wiki/Markdown)
* [jekyllrb.com](https://jekyllrb.com/)
* [kramdown](https://kramdown.gettalong.org/)
* [html.com: a Target](https://html.com/attributes/a-target/)
* [caktusgroup.com: Opening External Links Same Tab or New](https://www.caktusgroup.com/blog/2017/03/01/opening-external-links-same-tab-or-new/)
* [uxmovement.com: Why External Links Should Open in New Tabs](https://uxmovement.com/navigation/why-external-links-should-open-in-new-tabs/)
