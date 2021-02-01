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

> This form was curated with care by <3rd party company>.

Basically, they all advertised right on my website. Obviously I'm aware that this is a core part of those platforms... if I don't pay them any money, they can add on whatever advertisements they want. But I didn't like any of that.

I wanted a form solution that looked native... I didn't want it to be obvious to the user's naked eye that I was using any type of 3rd party services. I wanted my form completely built-in into the HTML, and I wanted my own custom "thank you" page. So I realized my solution was right in front of me.

There's a service I already use, which provides simple, yet customizable, form options: Google Forms. After a little bit of quick googling, I came across [this gem](https://www.developerdrive.com/add-google-forms-static-site/). Apparently, there's a way to create a Google Form, and then create a matching form in my HTML. And then I can hook up my HTML's action and inputs to the Google Form. Then, I can receive an email when somebody sends me a message, and Google Forms will automatically reroute my responses to a spreadsheet for me to look at and respond to (if needed).

I won't go through the details how to set up the Google Form and how to hook it up to your HTML... the linked [blog post](https://www.developerdrive.com/add-google-forms-static-site/) explains everything. This is what my final HTML looked like:

```html
<script type="text/javascript">
  var submitted=false;

  function showFormResponse() {
    document.getElementById("formResponse").style.display = "block";
    document.getElementById("form").remove();
  };
</script>

<iframe name="hidden_iframe"
        id="hidden_iframe"
        style="display: none;"
        onload="if (submitted) { showFormResponse() }">
</iframe>

<div id="form" class="page-body">
  <form method="post" target="hidden_iframe" onsubmit="submitted = true;"
    action="https://docs.google.com/forms/d/e/ABDEFGHIJKLMNOPQRSTUVWXYZ/formResponse"
  >
    <div class="form-group">
      <label>Full Name<span style="color: #d61b1b;">*</span></label>
      <input name="entry.01234567890" type="text" class="form-control" id="name" autocapitalize="words" placeholder="John Doe" required>
    </div>

    <div class="form-group">
      <label>Email<span style="color: #d61b1b;">*</span></label>
      <input name="entry.09876543210" type="email" class="form-control" id="email" placeholder="johndoe@example.com" required>
    </div>

    <div class="form-group">
      <label>Message<span style="color: #d61b1b;">*</span></label>
      <textarea name="entry.01928374650" class="form-control" id="message" placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit." rows="3" required></textarea>
    </div>

    <button type="submit" id="submitButton" class="btn btn-primary" style="width: 100%;">
      Submit
    </button>
  </form>
</div>

<div id="formResponse" class="page-body" style="display: none;">
  Thank you for your message! I will get back to you as soon as I can.

  <div class="text-center container" style="padding-top: 2rem; padding-bottom: 1rem;">
    <a href="/" class="btn btn-lg btn-outline-secondary">Back to Homepage</a>
  </div>
</div>
```

Here is a picture of what the form now looks like:

<!-- TODO: Insert picture here -->

Voilá! Now my users can submit this form, which will be sent to my Google Form automatically. And then they'll be shown a nice message indicating that I received their message. From a user's viewpoint, they won't even be able to tell the backend is through Google Forms.

But there is a next step... how do I prevent spam messages?
