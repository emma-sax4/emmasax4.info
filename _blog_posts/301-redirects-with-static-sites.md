---
layout: post
title: "301 Redirects with Static Sites"
permalink: /blog/posts/301-redirects-with-static-sites/
draft: true
---

This past weekend, I made the big decision to move the domain of my primary website from `https://emmasax4.info` to `https://emmasax4.com`. The main reason I wanted to do this was simply because I actually liked the idea of a `.com` domain. What I read online was that a `.com` domain is oftentimes the default, it's what people tend to remember most, etc. The reason I originally purchased a `.info` domain was because I'm not a commercial business. I'm not trying to sell anything. But `.info` stands for "information", which was originally information about a famous person, place, thing, or concept. Although I am a person, it just didn't feel right. But somehow, one year into revamping of this site and my "branding", `emmasax4.com` just felt right. Whether any of this is true or not may be a debate on the internet for a while, but I figured, my website, my domain, my decision.

Anyway, my domain isn't what this blog post is supposed to be about. It's supposed to be about the actual switch. So, there were four things I realized I needed to do to actually switch out the domains.

Firstly, I needed to rename my repository (this repository). Doing this was actually pretty straightforward. Here's the [pull request]({{ site.author_profiles.github }}/{{ site.github_repo }}/pull/305). I used a selective find/replace, made the pull request, merged, and then changed the name in the settings of the repository.

Secondly, I needed to actually change the website. This was a bit longer. I had to find/replace a bunch of places in the code, including in blog posts where I had hard-coded the website name (most likely as a code block). I had to update the `CNAME` file (which actually switches the domain GitHub tries to host the site at). The other two biggest things I had to do was change the Google/Yandex tokens for my SEO ratings (I had to add a "new" site to Google, Yandex, and Bing in order to have those search engines track the new domain). And I removed a bunch of redirects. Although it'd be nice if all of those redirected nicely, I realized it wasn't a priority anymore. What was a higher priority was making `https://emmasax4.info` redirect to `emmasax4.com`. And here is where I realized that with a static site, there's no super-easy way to make awesome redirects.

The tool that I use to set up my DNS has an easy way to set up redirects. They're functional, and so that's great. But, I wanted my redirects to be fancier. If somebody types in `https://emmasax4.info`, they should be redirected to `https://emmasax4.com`. But what if they pass in something like this: `https://emmasax4.info/path/to/webpage/`? They should be redirected to `https://emmasax4.com/path/to/webpage/`. And my DNS provider wasn't capable of providing that service (transferring path when redirecting). So, I looked for simple, free, easy-to-implement alternatives that could redirect all URLs.

---

To summarize, the basic steps I used to change the domain on my static site with GitHub Pages:

1. Rename the repository ([{{ site.author_profiles.github }}/{{ site.github_repo }}/pull/305]({{ site.author_profiles.github }}/{{ site.github_repo }}/pull/305))
2. Update where the project name is hard-coded ([{{ site.author_profiles.github }}/{{ site.github_repo }}/pull/306]({{ site.author_profiles.github }}/{{ site.github_repo }}/pull/306))
3. Change domain (and set up SSL certificates if needed)
4. Create redirects from old domain to new domain ([{{ site.author_profiles.github }}/emmasax4-redirects]({{ site.author_profiles.github }}/emmasax4-redirects))
5. Set up SEO trackers to monitor new domain
6. Wait a few months
7. Turn off redirects
8. Release (or retire) old domain
