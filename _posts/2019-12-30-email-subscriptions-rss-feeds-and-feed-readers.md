---
layout: post
title: Email Subscriptions, RSS Feeds, and Feed Readers
tags: [ tech ]
---

Earlier this week, a reader of this site (no, not my mother) emailed me saying that they wish that my blog had a "Subscribe" feature so they could be notified when a new blog post is published. I decided that it could be cool to implement that feature, although it may be difficult given my site doesn't have a database or a backend.

The two most popular forms of subscription is an email service, and a live RSS feed. I started with the email service. The idea is that there's a form for subscribers (or soon-to-be subscribers) to fill out where they enter their email address, and then a 3rd party service will add them to a list of subscribers. They'll receive an email saying they successfully subscribed, and then they'll receive an automated email whenever a new blog post is posted.

I followed [this guide](https://blog.webjeda.com/jekyll-subscribe-form/){:target="blank"} for setting up email notifications with [MailChimp](https://mailchimp.com/){:target="blank"}. The embedded subscription form worked, the automated welcome email worked, and it was all great! Except for one big thing: the [CAN-SPAM Act](https://www.ftc.gov/tips-advice/business-center/guidance/can-spam-act-compliance-guide-business){:target="blank"}.

Now, don't get me wrong, that law is definitely useful and great, but for somebody that doesn't own a business, isn't selling any products, and isn't making any money off of these emails, it seems sort of silly that I need to include a physical address where I can receive old-fashioned snail mail. I don't have an office, and I don't even rent a P.O. box. I _could_ rent a P.O. box, for about $8/month. But I don't want to be dabbling in renting a P.O. box that I won't really get any mail to, just so I can send out occasional emails to my family and friends. So, if it weren't for the physical address limitation, I'd probably still be using the email subscription.

So instead, I began looking into an RSS feed. This is the <i color="orange" data-feather="rss"></i> icon that you see on this page, and you can probably find a similar icon elsewhere on the internet, too. RSS feeds were originally made with the goal of providing users of sites with a basic overview of the posts on a page, and updates on each page. A user utilizes a [feed reader](https://whatis.techtarget.com/definition/RSS-reader){:target="blank"} to make a list of all of the feeds their interested in, and then that reader would send them updates about new posts, and link to the full post on each site. But... RSS feed readers never really gained popularity (most readers prefer to just bookmark a site and go back to it to look for updates).

But, since a reader requested it, I'll play along and implement an RSS feed on my site, too. I followed [this blog](https://joelglovier.com/writing/rss-for-jekyll){:target="blank"} to help me add the RSS feed to my site. It turned out to be super easy. There's no gem requirement, and it doesn't use any 3rd party service to compile properly. It updates the feed whenever `bundle exec jekyll build` is run, and auto-updates when I'm actively serving my site locally.

I added these values to my `_config.yml`:
```
feed_title: Emma Sax's Blog
feed_url: https://emmasax4.info/blog/
feed_items: 5
```
and added this file to the root of my repository:
```
---
layout: none
---

{% raw %}<?xml version="1.0" encoding="UTF-8"?>{% endraw %}
{% raw %}<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">{% endraw %}
{% raw %}  <channel>{% endraw %}
{% raw %}    <title>{{ site.feed_title | xml_escape }}</title>{% endraw %}
{% raw %}    <description>{{ site.feed_description | xml_escape }}</description>{% endraw %}
{% raw %}    <link>{{ site.feed_url }}</link>{% endraw %}
{% raw %}    <atom:link href="{{ site.url }}/feed.xml" rel="self" type="application/rss+xml" />{% endraw %}
{% raw %}    {% for post in site.posts limit: site.feed_items %}{% endraw %}
{% raw %}      <item>{% endraw %}
{% raw %}        {% if post.subtitle %}{% endraw %}
{% raw %}          {% assign short_title = post.title | append: " → " | append: post.subtitle %}{% endraw %}
{% raw %}        {% else %}{% endraw %}
{% raw %}          {% assign short_title = post.title %}{% endraw %}
{% raw %}        {% endif %}{% endraw %}
{% raw %}        <title>{{ short_title | xml_escape }}</title>{% endraw %}
{% raw %}        <description>{{ post.description | xml_escape }}</description>{% endraw %}
{% raw %}        <pubDate>{{ post.date | date: "%a, %d %b %Y %H:%M:%S %z" }}</pubDate>{% endraw %}
{% raw %}        <link>{{ site.url }}{{ post.url }}</link>{% endraw %}
{% raw %}        <guid isPermaLink="true">{{ site.url }}{{ post.url }}</guid>{% endraw %}
{% raw %}      </item>{% endraw %}
{% raw %}    {% endfor %}{% endraw %}
{% raw %}  </channel>{% endraw %}
{% raw %}</rss>{% endraw %}
```

And it works! It works locally and in `production`. I can validate my feed [here](https://validator.w3.org/feed/){:target="blank"}, and I can add my own feed to my feed reader to test it out locally and on master.

Now we're only left with this question: which feed reader is best? I'm still figuring out the answer to that question. I used [feeder.co](https://feeder.co/reader){:target="blank"} for most of my testing while implementing this, but it costs about $10/month, and I was just using a free trial. Granted, it did seem handy and it worked well 🤷🏻‍♀️. So now I've installed the [RSS Feed Reader Chrome extension](https://chrome.google.com/webstore/detail/rss-feed-reader/cdlhhcmmdobckneongkkmgigcimeibpf){:target="blank"}, and I'll play with this just long enough to see if posting a new blog (this one, actually) will update the feed reader. If it does seem to work, then I'll keep digging for the best feed reader out there (that's free... I'm cheap, remember?).

I do know that there are a plethora of mobile apps and desktop/laptop computer apps available that can help users read their feeds. There's probably even one that sends you an email when it detects a new content.

Please let me know if you currently use any great feed readers or if you come across one. I'll post any updates about my feed readers as they come up 😊. Good luck subscribing!

## References

* [mailchimp.com](https://mailchimp.com/){:target="blank"}
* [ftc.gov: CAN-SPAM act](https://www.ftc.gov/tips-advice/business-center/guidance/can-spam-act-compliance-guide-business){:target="blank"}
* [feeder.co](https://feeder.co){:target="blank"}
* [validator.w3.org: feed](https://validator.w3.org/feed/){:target="blank"}
* [joelglovier.com: RSS for Jekyll](https://joelglovier.com/writing/rss-for-jekyll){:target="blank"}
* [wikipedia.org: RSS](https://en.wikipedia.org/wiki/RSS){:target="blank"}
* [whatis.techtarget.com: RSS reader](https://whatis.techtarget.com/definition/RSS-reader){:target="blank"}
* [chrome.google.com: webstore, RSS feed reader](https://chrome.google.com/webstore/detail/rss-feed-reader/cdlhhcmmdobckneongkkmgigcimeibpf){:target="blank"}
