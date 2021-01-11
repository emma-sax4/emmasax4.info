---
layout: page
title: Contact Me
permalink: /contact-me/
---

Please use this form to contact me directly. Do not send me any solicitation, recruitment, or inappropriate messages.

<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<script type="text/javascript">
  var submitted=false;
</script>

<iframe name="hidden_iframe"
        id="hidden_iframe"
        style="display: none;"
        onload="if (submitted) { window.location='/contact-me/thank-you/'; }">
</iframe>

<form action="https://docs.google.com/forms/d/e/1FAIpQLScEq299mdRxHN_dZ3tTdgp6KTYtcgUHHVbDr0DSX2-zDDCxuQ/formResponse"
      method="post"
      target="hidden_iframe"
      onsubmit="submitted=true;"
>
  <div class="form-group">
    <label>Full Name<span style="color: #d61b1b;">*</span></label>
    <input name="entry.989289036" type="text" class="form-control" id="name" style="text-transform: capitalize;" placeholder="John Doe" required>
  </div>

  <div class="form-group">
    <label>Email<span style="color: #d61b1b;">*</span></label>
    <input name="entry.1580808807" type="email" class="form-control" id="email" placeholder="johndoe@example.com" required>
  </div>

  <div class="form-group">
    <label>Message<span style="color: #d61b1b;">*</span></label>
    <textarea name="entry.1379036791" class="form-control" id="message" placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit." rows="5" required></textarea>
  </div>

  <label>Please verify you're a person<span style="color: #d61b1b;">*</span></label>
  <div class="g-recaptcha" data-callback="recaptchaCallback" data-expired-callback="recaptchaExpiredCallback"
       data-sitekey="6Ld6_CcaAAAAAOXP4F6Ze2M5mbeqFRSEN9dlUecn" style="margin-top: -1rem; padding-bottom: .67rem;">
  </div>

  <button type="submit" id="submitButton" disabled class="btn btn-primary" style="width: 100%;">
    Submit
  </button>
</form>
