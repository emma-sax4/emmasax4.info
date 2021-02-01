---
layout: post
title: Adding HTML forms to Static Sites
tags: [ tech ]
permalink: /blog/posts/adding-html-forms-to-static-sites/
draft: true
---

Earlier this year, I realized that I wanted to add a new feature to my website: a contact form. I wanted an easy way for my readers and users to contact me and send me a personal message _without_ them directly knowing my email. Essentially, I wanted a way for them to write me a short message, and then I'd receive an email when they submitted their message.

It turns out there's lots of 3rd party tools that can be used to accomplish these, many of them for free. I looked at [Getform](https://getform.com/), [Formspree](https://formspree.io/), and [Kwes](https://kwes.io/). I even went as far as to make accounts on some of those platforms and to test out what the integration would look like. [This blog post](https://css-tricks.com/a-comparison-of-static-form-providers/) can give you an idea of how many options of this there are.

Each platform I tested out had its own pros and cons. Some of them had limits on how many receiving submissions I could receive per month. Some had limited methods of integrating them on my HTML (basically forcing me to embed a form versus use HTML to create my own, and then just submit to their backend). Some of them redirected to their own "thank you" page (the page users see after submitting), and I didn't like that. At the end of the day, I probably could've been content with any of the options I trialled (I never actually paid for any service.... everything on my site is free—except the domain—and I'd like to keep it that way). But none of them were _exactly_ the way I wanted. And furthermore, all of them had some sort of message that said:

> This form was curated by <3rd party company>.

Basically, they all advertised right on my website. Obviously I'm aware that this is a core part of those platforms... if I don't pay them any money, they can add on whatever advertisements they want. But I didn't like any of that.

I wanted a form solution that looked native... I didn't want it to be obvious to the user's naked eye that I was using any type of 3rd party services. I wanted my form completely built-in into the HTML, and I wanted my own custom "thank you" page. So I realized my solution was right in front of me.

There's a service I already use, which provides simple, yet customizable, form options: Google Forms. After a little bit of quick googling, I came across [this gem](https://www.developerdrive.com/add-google-forms-static-site/). Apparently, there's a way to create a Google Form, and then create a matching form in my HTML. And then I can hook up my HTML's action and inputs to the Google Form.

Then, I can receive an email when somebody sends me a message, and Google Forms will automatically reroute my responses to a spreadsheet for me to look at and respond to (if needed).
