---
layout: post
title: "301 Redirects with Static Sites"
tags: [ tech ]
permalink: /blog/posts/301-redirects-with-static-sites/
date: 2020-10-04 12:00:00 -0500
---

This past weekend, I made the big decision to move the domain of my primary website from `https://emmasax4.info` to `https://emmasax4.com`. The main reason I wanted to do this was simply because I actually liked the idea of a `.com` domain. What I read online was that a `.com` domain is oftentimes the default, it's what people tend to remember most, etc. The reason I originally purchased a `.info` domain was because I'm not a commercial business. I'm not trying to sell anything. But `.info` stands for "information", which I later learned was originally designated for information about a famous person, place, thing, or concept. Although I am a person, it just didn't feel right. But somehow, one year into the revamping of this site and my "branding", `emmasax4.com` just felt right. Whether any of this is true or not may be a debate on the internet for a while, but I figured, my website, my domain, my decision 💪🏼.

Anyway, my domain isn't what this blog post is supposed to be about. It's supposed to be about the actual switch 🔁. So, there were five 5️⃣ core things I realized I needed to do immediately to actually switch out the domains.

Firstly, I needed to rename my repository (this repository). Doing this was actually pretty straightforward. Here's the [pull request]({{ site.author_profiles.github }}/{{ site.github_repo }}/pull/305). I used a selective find/replace, made the pull request, merged, and then changed the name in the settings of the repository 🙌🏼.

Secondly, I needed to actually change the website. This was a bit longer. I had to find/replace a bunch of places in the code, including in blog posts where I had hard-coded the website name (most likely as a code block). The other big things I had to do in this pull request was change the Google/Yandex tokens for my SEO crawlers (I had to add a "new" site to Google, Yandex, and Bing in order to have those search engines track the new domain)—more on this later. I had to update the `CNAME` file as well, which is what would eventually tell GitHub Pages to do the full domain switch—this became the third 3️⃣ item.

Lastly, I removed a bunch of old blog post redirects (learn more about those redirects I set up [here](/blog/posts/time-zones-utc-and-javascript-oh-my/)). Although it'd be nice if all of those continued redirecting nicely, I realized it wasn't a priority anymore. What was a higher priority was making `https://emmasax4.info` redirect to `https://emmasax4.com`. This leads into the next item.

Fourth, I needed to make redirects from the old site to the new site. And here is where I also learned that with a static site, there's no super-easy way to make awesome redirects 😿.

The tool that I use to set up my DNS has an easy way to set up redirects. They're functional, and so that's great. But, I wanted my redirects to be fancier. If somebody types in `https://emmasax4.info`, they should be redirected to `https://emmasax4.com`. But what if they pass in something like this: `https://emmasax4.info/path/to/webpage/`? They should be redirected to `https://emmasax4.com/path/to/webpage/`. And my DNS provider wasn't capable of providing that service (transferring URL path when redirecting). So, I looked for simple, free, easy-to-implement alternatives that could redirect all URLs 🤔.

What I found was [this solution](https://opensource.com/article/19/7/permanently-redirect-github-pages) from Oleksii Tsvietnov. The idea is to make a new GitHub repository that will publish to GitHub Pages with the old domain. And then, create an `index.html` file which will redirect to the new domain. So, when a user navigates to the old domain, they'll hit the new GitHub Pages with your new `index.html`, and then it'll redirect automatically to the new domain (which is hosted on the original GitHub Pages repository) 🤯.

I created [this repository]({{ site.author_profiles.github }}/emmasax4-redirects) to put my new redirects in. I started by taking a modified version of the HTML code in that blog post, which looked something like this:

```html
<!DOCTYPE html>
<html lang="en-US">
  <meta charset="utf-8">
  <title>Redirecting&hellip;</title>
  <link rel="canonical" href="https://destination-domain.com">
  <script>
    location="https://destination-domain.com"
  </script>
  <meta http-equiv="refresh" content="0; url=https://destination-domain.com">
  <meta name="robots" content="noindex">
  <h1>Redirecting&hellip;</h1>
  <a href="https://destination-domain.com">Click here if you are not redirected.</a>
</html>
```

This worked. I duplicated each `index.html` file on the original site into this new project, replicating the files found [here]({{ site.author_profiles.github }}/{{ site.github_repo }}/tree/4c4aaed77f44ccf743ce47ddef9c91c9a89528a4). But I realized this wasn't sustainable. I didn't want to be copy-pasting HTML from each file to another all over the place. I wanted _one_ HTML file that would properly redirect any incoming path to the new domain, and forwarding the same path, without me having to make constant updates to the new redirect repository.

Furthermore, I wanted users to know I was redirecting them. I didn't want to do it under the hood, with them potentially not even noticing they were redirected. I wanted them to have a clear message they were being redirected, and for them to know that they were redirecting to a reputable new site. I wanted the redirect page to _look_ like my existing website, so it was clear they were still within the realm of my original site.

So, the first thing I did was add CSS. I copy-pasted the `./assets/` directory from [the main repository]({{ site.author_profiles.github }}/{{ site.github_repo }}/tree/4171201807c9e217372dafd130543e5a2da79bba/assets) to the new repository. I did a selective copy-paste, only copying the CSS, JS, and images that the new "site" required. And then I called those assets straight from my `index.html`, just like in my core repository. I opted not to include the full navigation bar, but just showing a basic blue top bar, to make it feel like it was still my website.

<div class="text-center">
  {% include elements/photo.html
      url="https://live.staticflickr.com/65535/50413992607_ef05913653_h.jpg"
      thumb_width="300" title="emmasax4.info redirecting" lightbox="Redirecting"
  %}
</div>

And then the last couple tricks was to add two ways to do the redirect. One was a delayed redirect. So a user would sit on the redirect page for five seconds to be able to comprehend what was happening and then they'd be automatically redirected. The second was for an easy way for the user to redirect themselves. This eventually turned into a button. The tricky part of both of these was forwarding the incoming path. It turns out, the easiest way to do this is to actually use Javascript instead of HTML, like the original blog post suggests. For example, this is how you could read the incoming path that is navigated to, and pass it on in a delayed redirect:

```js
pathname = window.location.pathname;
setTimeout(function(){ window.location.href = "https://destination-domain.com" + pathname;}, 5000);
```

Now, with this Javascript, the key was to use it in two places: the button, and the delay. This was the ending solution:

```html
<script type="text/javascript">
  var pathname = window.location.pathname;

  // Perform an automatic timed redirect
  setTimeout(function(){ window.location.href = "https://destination-domain.com" + pathname;}, 5000);

  // Add button click functionality as well
  function redirect_now() {
    window.location.href = "https://destination-domain.com" + pathname;
  };
</script>

<button class="btn btn-lg btn-outline-secondary" onclick="redirect_now(); return false;">
  Click here if you are not redirected.
</button>
```

Bam! Now, no matter what path a user passes in after the `/`, they'll be forwarded to the exact same URL with just a different domain 🥳. The last part of this project was to remove all of the extra `index.html` files. All we really need are the root `index.html` to catch when someone navigates to `https://emmasax4.info` directly, and a page to catch when somebody navigates to.... anything else (`https://emmasax4.info/anything/else/goes/here`). In that case, we can just make a `404.html` file. If the user navigates to anything else besides the plain root, then GitHub Pages will show the `404.html` page. And if the `404.html` functionality redirects to the new domain, _while passing the end of the path (`/anything/else/goes/here`)_, then the `404.html` page acts as a catch-all. So, I created a symlinked file off of the `index.html` page:

```bash
ln -s index.html 404.html
```

This way, if I change one of the HTML files, it'll automatically change the other one. My final HTML files look like [this]({{ site.author_profiles.github }}/emmasax4-redirects/blob/13d56749a2675a667bce280c3c701e98453fd784/index.html).

The fifth step for me to do in the "soonish" future was to update my SEO trackers, indexers, and crawlers. I previously used Google Search Console, Bing, and Yandex to do my SEO tracking. In each of those, I had the option to add a new website or domain (`https://emmasax4.com`). And on Google, I also used the feature to do a "Change of Address." So for Google, I added the new URL prefix site _and_ completed the Change of Address. Google describes the use of that tool [here](https://support.google.com/webmasters/answer/9370220?hl=en).

The next steps are to wait a few months. This is easy! Google recommends waiting a minimum of six months. Since I still own my old domain for a while, I'm probably going to keep my redirects alive as long as possible, which in my case will be over a year. I'll continue to monitor traffic, clicks, and impressions on tools like Cloudflare, Google Search Console, Yandex, and Bing. With any luck, the amount of traffic going towards the old domain will decrease within a few months, and the traffic on the new domain will increase. But after my waiting period is done, then I can turn off my redirects (in my case, turn off GitHub Pages on the [redirecting repository]({{ site.author_profiles.github }}/emmasax4-redirects)), and release or retire my old domain. If I so desire, I could keep the old domain forever and just eternally let it redirect... it's my choice.

---

To summarize, the basic steps I used to change the domain on my static site with GitHub Pages:

1. Rename the repository ([GitHub: {{ site.github_repo }}/pull/305]({{ site.author_profiles.github }}/{{ site.github_repo }}/pull/305))
2. Update where the project name is hard-coded ([GitHub: {{ site.github_repo }}/pull/306]({{ site.author_profiles.github }}/{{ site.github_repo }}/pull/306))
3. Change domain through GitHub Pages settings (or by merging the changes to the `CNAME` file) and set up SSL certificates for the new domain if needed
4. Create redirects from old domain to new domain ([GitHub: emmasax4-redirects]({{ site.author_profiles.github }}/emmasax4-redirects))
5. Set up SEO trackers to monitor new domain
6. Wait a several months and monitor traffic to old domain as you go
7. (OPTIONAL) Turn off redirects
8. (OPTIONAL) Release (or retire) old domain
