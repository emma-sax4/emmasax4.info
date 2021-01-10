---
layout: page
title: Contact Me
permalink: /contact-me/
---

Please use this form to contact me directly. Do not send me any inappropriate, solicitation, or recruitment messages.

<script type="text/javascript">
  var submitted=false;
</script>

<iframe name="hidden_iframe"
        id="hidden_iframe"
        style="display: none;"
        onload="if (submitted) { window.location='/contact-me/thank-you/'; }">
</iframe>

<form action="https://docs.google.com/forms/u/0/d/e/1FAIpQLScEq299mdRxHN_dZ3tTdgp6KTYtcgUHHVbDr0DSX2-zDDCxuQ/formResponse"
      method="post"
      target="hidden_iframe"
      onsubmit="submitted=true;"
>
  <div class="form-group">
    <label>Full Name*</label>
    <input name="entry.989289036" type="text" class="form-control" id="name" placeholder="John Doe" required>
  </div>

  <div class="form-group">
    <label>Email*</label>
    <input name="entry.1580808807" type="email" class="form-control" id="email" placeholder="johndoe@example.com" required>
  </div>

  <div class="form-group">
    <label>Message*</label>
    <textarea name="entry.1379036791" class="form-control" id="message" placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit." rows="5" required></textarea>
  </div>

  <button type="submit" class="btn btn-primary" style="width: 100%;">
    Submit
  </button>
</form>
