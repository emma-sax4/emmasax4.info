---
layout: post
title: Adding HTML forms to Static Sites
tags: [ tech ]
permalink: /blog/posts/adding-html-forms-to-static-sites/
date: 2021-02-05 02:00:00 -0600
---

A few weeks ago, I realized that I wanted to add a new feature to my website: a contact form. I wanted an easy way for my readers and guests to contact me and send me a personal message _without_ them directly knowing my email. I wanted a way to allow them to write me a short message, and then I'd receive an email when they submitted their message. Perhaps by removing my email from my HTML, I'm also slowing down some spam messages, too.

It turns out there's lots of 3rd party tools that can be used to accomplish these, many of them for free. I looked at [Getform](https://getform.com/), [Formspree](https://formspree.io/), and [Kwes](https://kwes.io/). I even went as far as to make accounts on some of those platforms and to test out what the integration would look like. [This blog post](https://css-tricks.com/a-comparison-of-static-form-providers/) can give you an idea of how many options there are.

Each platform I tested out had its own pros and cons. Some of them had limits on how many submissions I could receive per month. Some had limited methods of integrating them on my HTML (basically forcing me to embed their HTML form versus create my own HTML form and then just submit to their backend). Some of them redirected to their own "thank you" page (the page users see after submitting), and I didn't like that. At the end of the day, I probably could've been content with any of the options I trialled (I never actually paid for any service... everything on my site is free—except the domain—and I'd like to keep it that way). But none of them were _exactly_ the way I wanted. And furthermore, all of them had some sort of message that said:

> This form was made by <3rd party company>.

Basically, they all advertised right on my website. Obviously I'm aware that this is a core part of those platforms... if I don't pay them any money, they can add on whatever advertisements they want. But I didn't like any of that.

I wanted a form solution that looked native... I didn't want it to be obvious to the user's naked eye that I was using any type of 3rd party services. I wanted my form completely built-in into the HTML, and I wanted my own custom "thank you" page. So I realized my solution was right in front of me.

There's a service I already use, which provides simple, yet customizable, form options: Google Forms. After a little bit of quick googling, I came across [this gem](https://www.developerdrive.com/add-google-forms-static-site/). Apparently, there's a way to create a Google Form, and then create a matching form in my HTML. And then I can hook up my HTML's action and inputs to the Google Form. Then, I can receive an email when somebody sends me a message, and Google Forms will automatically reroute my responses to a spreadsheet for me to look at, track data, and respond to (if needed).

Here are all of the steps to complete the Google Form setup. I'll describe each step one-by-one:

1. Create a Google Form
2. Create a custom HTML form that mirrors the Google Form
3. Add the Google Form's `name` and `action` values to the HTML form
4. OPTIONAL: Redirect to a custom "thank you" page upon form submission
5. Sign up for Google reCAPTCHA and add the reCAPTCHA HTML to the HTML form
6. Add a verification entry to the Google Form
7. Add an _invisible_ verification input to the HTML form
8. Create callback methods for reCAPTCHA
9. Upon callback method, do the following:
    * Enable the submission button
    * Fill in the invisible input in the HTML form
10. Upon callback expiration, do the following:
    * Disable the submission button
    * Empty the invisible input in the HTML form
11. Test!

For the first four steps (creating a Google Form, creating a custom HTML form that mirrors the Google Form, adding the Google Form's `name` and `action` values to the HTML form, and redirect to a "thank you" page), please follow [this blog post](https://www.developerdrive.com/add-google-forms-static-site/), as it perfectly explains everything. That's the blog post I followed, and it was pretty easy to follow and understandable.

Here's what my final HTML form looks like. Note that instead of rendering an entirely new "thank you" page, I simply replace the form `div` with a "thank you" `div`. This is my personal preference, so that there's not an entirely new page just to say thanks for submitting a message.

```html
{% raw %}<script>
  var formSubmitted = false;

  function showFormResponse() {
    document.getElementById("formResponse").style.display = "block";
    document.getElementById("form").remove();
  };
</script>

<iframe name="hidden_iframe"
        id="hidden_iframe"
        style="display: none;"
        onload="if (formSubmitted) { showFormResponse() }">
</iframe>

<div id="form">
  <form method="post" target="hidden_iframe" onsubmit="formSubmitted = true;"
    action="https://docs.google.com/forms/d/e/ABDEFGHIJKLMNOPQRSTUVWXYZ/formResponse"
  >
    <div class="form-group">
      <label>Full Name*</label>
      <input name="entry.01234567890" type="text" class="form-control" id="name" placeholder="John Doe" required>
    </div>

    <div class="form-group">
      <label>Email*</label>
      <input name="entry.09876543210" type="email" class="form-control" id="email" placeholder="johndoe@example.com" required>
    </div>

    <div class="form-group">
      <label>Message*</label>
      <textarea name="entry.01928374650" class="form-control" id="message" placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit." rows="3" required></textarea>
    </div>

    <button type="submit" id="submitButton">Submit</button>
  </form>
</div>

<div id="formResponse" style="display: none;">
  Thank you for your message! I will get back to you as soon as I can.

  <div class="text-center">
    <a href="/" class="btn">Back to Homepage</a>
  </div>
</div>{% endraw %}
```

Here is a picture of what the form now looks like:

<div class="text-center photoswipe-gallery">
  {% include elements/photoswipe.html
     url="https://live.staticflickr.com/65535/50910867482_e25fc606ba_b.jpg"
     thumb_width="400" title="A basic HTML form"
     full_width="375" full_height="168"
  %}
  {% include elements/photoswipe.html
     url="https://live.staticflickr.com/65535/50910770391_a88fce2728_c.jpg"
     thumb_width="400" title="The 'thank you' that is shown upon submission"
     full_width="375" full_height="123"
  %}
</div>

Voilá! Now my users can submit this form, which will be sent to my Google Form automatically. And then they'll be shown a nice message indicating that I received their message. From a user's viewpoint, they won't even be able to tell the backend is through Google Forms. This achieves everything I wanted in my contact form.

But there is a next step... how do I prevent those spam messages? There are several simple ways you can do that with Google Forms. I could add a question that just asks something like what's 2+2? And then I accept the answer 4, four, FOUR, etc. But I want my form to look as professional as possible. Therefore, I decided an easy thing I could do was add a reCAPTCHA check. This is one of those checks that requires users to click all the pictures with sidewalks (or something else to solve a little puzzle) to verify that the person is indeed a human being (not spam or a bot). Clearly, some spammers will still manage to get through the reCAPTCHA, but it can do a lot when it comes to preventing repeated spam messages.

So now we move onto the fifth step: signing up for Google's reCAPTCHA and adding it to our form. I signed up for a reCAPTCHA from Google [here](https://www.google.com/recaptcha/admin/create), and then implemented the reCAPTCHA with the instructions documented [here](https://developers.google.com/recaptcha/docs/display). Unfortunately, there's not a great way to _verify_ the reCAPTCHA with a static HTML site, since I'm not in control of my form's backend. If I did try to implement formal verification, it would result in exposing my reCAPTCHA's secret key over public code. However, I did save the secret key for future reference.

Here's my reCAPTCHA HTML code looks like. I just plopped it into the end of my form before the submission button.

```html
<label>Please verify you’re a human*</label>
<div class="g-recaptcha" a-sitekey="reCAPTCHA-site-key-goes-here"></div>
```

Now my form visually looks like it's requiring the reCAPTCHA:

<div class="text-center photoswipe-gallery">
  {% include elements/photoswipe.html
      url="https://live.staticflickr.com/65535/50910047008_50718a7f0e_b.jpg"
      thumb_width="600" title="Form with the reCAPTCHA"
      full_width="375" full_height="209"
  %}
</div>

However, since we're not actually verifying the reCAPTCHA anywhere, there's nothing that's actually _requiring_ a user to click the button. Most people would probably assume it's required, so they'd most likely just verify without thinking twice. But it only took my partner five minutes to let me know that it wasn't required and that anyone (or anybot) could bypass it.

So, if I'm not in control of my form's backend, how do I verify that the user correctly completed the reCAPTCHA? Well, I decided that my form verification would be not through verifying the token provided by reCAPTCHA (as we're supposed to), but to instead verify on Google Form's side. This is less spam-proof than if I managed to actually verify the token through Google's API, but it'll be a close second, and I'm hoping that I'll still be able to prevent most of the spam messages.

So now we're onto step six. I added a short-answer question to my Google Form, and just called it "Anti-Spam Verification". It doesn't actually really matter what it's called. The important thing is that we implement a regex validator on that question. Read more about regex validators on Google Forms [here](https://www.labnol.org/internet/regular-expressions-forms/28380/). To keep it simple at the beginning, I just set it up to validate that a specific 14 character code is sent; I would update the required regex later.

Now, in step seven, I'll add another form input to my HTML, and attach it to the new Google Forms question:

```html
{% raw %}<div class="form-group" style="display: none">
  <label>Anti-Spam Verification</label>
  <input name="entry.102938475" type="text" class="form-control" id="verification" required>
</div>{% endraw %}
```

I can put this section pretty much anywhere in the entire form—the `style="display: none"` makes it so that it's invisble by default. By making it required, I'm telling the form that it cannot be sent without that input being filled out (with anything... the HTML form doesn't care what's there).

Now, in step 8, I'm going to create two Javascript methods, called callback methods. Google's poor documentation explains a little bit about callback methods [here](https://developers.google.com/recaptcha/docs/display#render_param).

```javascript
function recaptchaCallback() {
  // TODO: we'll add some things here later...
};

function recaptchaExpiredCallback() {
  // TODO: we'll add some things here later...
};
```

And now call those two new methods from within the reCAPTCHA `div`:

```html
<div class="g-recaptcha"
     data-callback="recaptchaCallback"
     data-expired-callback="recaptchaExpiredCallback"
     a-sitekey="reCAPTCHA-site-key-goes-here">
</div>
```

These callback methods are built-in to the reCAPTCHA, so the `data-callback` is automatically called when somebody fulfills the reCAPTCHA, and if/when the verification expires (the verification expires after two minutes), then the `data-expired-callback` is automatically called. As an additional detail, I set the submission button to start off as `disabled`, so that it's clear to a human user that you cannot submit until the reCAPTCHA is complete (this wouldn't prevent a bot from submitting, and a user could just remove the `disabled` word in the browser inspect tool):

```html
<button type="submit" id="submitButton" disabled>Submit</button>
```

And now, steps nine and ten. To fill in the functionality of those two methods. On the `data-callback` method, we'll do two things: 1) enable the submission button, and 2) fill in the "Anti-Spam Verification" field on the HTML form:

```javascript
function recaptchaCallback() {
  $("#submitButton").removeAttr("disabled");
  document.getElementById("verification").value = "<14 character code that Google Form expects>";
};
```

Here, we remove the `disabled` part of the submission button, and we find the `"verification"` element and set the value to the code that we set the Google Forms to require.

Next, we'll fill in what should happen if the reCAPTCHA expires:

```javascript
function recaptchaExpiredCallback() {
  $("#submitButton").attr("disabled", true);
  document.getElementById("verification").value = null;
};
```

Here, we'll 1) disable the submission button again, and 2) set the `"verification"` element to `null`. Once again, changing the button to be enabled/disabled is really only for people visually on my site—it's not fancy enough to prevent any sort of spam. However, the setting and resetting of the `"verification"` element _would_ hopefully prevent those bots.

And now for step eleven... testing! When testing, I found that as expected, I could not submit anything without first completing the reCAPTCHA. If I never complete the reCAPTCHA, I cannot submit a message. If I complete the reCAPTCHA, and then wait until it expires, then I cannot send the message. If I follow a happy path scenario (fill out a message, complete reCAPTCHA, press submit), then it successfully enters my Google Forms' spreadsheet.

Now, here's where it gets fancy. If I go into the browser's inspection tool, remove the `disable` on the button, and show the invisible `"verification"` form input, then I can enter a random value into the invisible input, and press submit... all without completing the reCAPTCHA. My website even gives a nice message that the submission was successful (as a little decoy). _However_, Google Forms never receives the message. Google Forms returns a `400` on the `FormResponse` (this can be seen in the browser's inspection tool), and the message goes into a black hole, never to be seen again. Google Forms can only _receive_ the message if the invisible verification input's string _exactly matches_ the specific regex I set in Google Forms.

<div class="text-center photoswipe-gallery">
  {% include elements/photoswipe.html
      url="https://live.staticflickr.com/65535/50910770401_aa13b0dec4_c.jpg"
      thumb_width="500" title="A demonstration of what a spam message could 'look' like"
      full_width="375" full_height="198"
  %}
</div>

Now, asking for a 14 character code, which is hard-coded into my source code, isn't very secure. Any person that _really_ wanted to spam me (but please don't) could look in my code, find the 14 character code, and write a little script to send me repeated messages. So, I got fancier. I played around with different ways of taking Google's reCAPTCHA response, and combining it with a hard-coded "password". And then, I implemented a fancy regex on Google Forms to verify. Unfortunately for my readers, I won't be publicizing what regex I developed to verify the verification input, as that would compromise my backend verification.

So, that's it! It was a tedious process, but now it should be clear to my human users that they need to fill out the reCAPTCHA before submission (by enabling/disabling the submission button), and my form should prevent the majority of spam messages (by requiring a specific regex to be met upon submission).

All of my completed HTML can be found [here]({{ site.author_profiles.github }}/{{ site.github_repo }}/blob/c653cdd5004ce573edb5ccbda992f76bf0f5ba8f/_layouts/contact.html#L14-L65). Please let me know if you have any questions, comments, or concerns! Best of luck adding some forms to your static site.

## References

* [Getform](https://getform.com/)
* [Formspree](https://formspree.io/)
* [Kwes](https://kwes.io/)
* [css-tricks.com: A Comparison of Static Form Providers](https://css-tricks.com/a-comparison-of-static-form-providers/)
* [www.developerdrive.com: How To Add Google Forms to Your Static Site](https://www.developerdrive.com/add-google-forms-static-site/)
* [www.google.com: ReCATPCHA creation](https://www.google.com/recaptcha/admin/create)
* [developers.google.com: ReCAPTCHA docs](https://developers.google.com/recaptcha/docs/display)
* [www.labnol.org: Useful Regular Expressions for Validating Input in Google Forms](https://www.labnol.org/internet/regular-expressions-forms/28380/)

---

EDIT: Since publishing this blog post, I've made one change to my form. Instead of making the invisible verification input required, I've instead added an additional check that will only show the "thank you" page if the reCAPTCHA was completed. Otherwise, it'll show a browser alert that the reCAPTCHA needs to be filled out first. Under the hood, the form actually tries to submit either way (whether the reCAPTCHA was completed or not), but Google Forms will just deny the request if the reCAPTCHA (and/or the invisible verification input) wasn't completed. To make it extra clear that the invisible input is required by the backend, just not enforced by the frontend, I wrote a little invisible message. This is what my new Javascript function looks like:

```javascript
function verifyRecaptcha() {
  if (recaptchaCompleted) {
    formSubmitted = true;
  } else {
    alert('Please fill out the reCAPTCHA to send a message.');
  };
};
```
