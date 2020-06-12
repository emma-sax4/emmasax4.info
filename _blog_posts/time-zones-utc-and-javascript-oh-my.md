---
layout: post
title: Time Zones, UTC, and Javascript... Oh My!
tags: [ tech ]
permalink: /blog/posts/time-zones-utc-and-javascript-oh-my/
date: 2020-02-07 00:00:00 -0600
---

On my latest blog post, I wanted to try something new. When publishing, I wanted to publish on a future date (specifically at midnight the next day). I set up the date of the post to include the next day, and then planned to go onto Travis at midnight to build the newest version of the site... with the new blog post. And then I continued working on my website for the night.

But what ended up happening was Travis CI built on my `release` branch at 6:15pm... and suddenly my new blog post was live 😱! What happened? Well, Travis CI by default runs in UTC. So, since 6:00pm in CST is midnight in UTC, Travis CI determined it was time to publish the blog post. I quickly reverted that commit on my `gh-pages` branch to hide the new post once again, and then worked to find a solution to make Travis CI behave for the remainder of the night.

What I ended up finding was this. By adding these lines to the `.travis.yml` file, we can override Travis CI's default time zone and have it bundle in CST.

```yml
before_install:
  - export TZ=America/Chicago
```

I thought I would be satisfied with this. I develop my site in CST (or CDT in the summer), and now Travis will also bundle in that time zone. But, after more thought, I realized that this is really just a bandaid fix 🤕. What if I move across the country and now live in a different time zone permanently? What if I'm traveling internationally (say in France), and I'm blogging while I'm there. I'm no longer going to be thinking in terms of `America/Chicago` time zone... say I publish a blog post at 12pm noon in France. When I get home to Minneapolis, should the blog post still show up as having been published at 12pm noon? Or should it properly show a 6–7 hour time difference?

So after a lot of thinking, I decided that the best (and most sustainable) way to design a website is so that all dates/times are UTC in the database (Jekyll doesn't have a DB, so just in the HTML, `feed.xml`, and `sitemap.xml`). Then, we can convert all UTC date/times to become in a user's local time when they navigate to my site ⏱.

## The Goal

Time zones are complicated. I've dabbled with them a little bit, but they tend to make my head spin 💫. So, I made hefty goal for myself 🥴. When I publish a blog post, I can specify the publish date/time in _my_ local time zone. Jekyll will build the blog post as having been published at the corresponding UTC time. And when a reader looks at the blog post on the website, it'll give the date/time in their local time zone (which may be _my_ time zone, but it could also be different).

Let's look at an example. I publish a blog post at 10:15pm in CST on Jan. 17, 2020:
```
2020-01-17 22:15:00 -0600
```

Jekyll will compile and store the blog post as having been published in UTC (notice the date change):
```
2020-01-18 04:15:00 +0000
```

But when a reader looks at the blog post online, it will show in their local time zone (I normally hide the specific times when showing publishing dates):
```
### CST - Minnesota
January 17, 2020 22:15

### PST - California
January 17, 2020 20:15

### CEST - France
January 18, 2020 05:15
```

Most of the time, I publish my blog posts at midnight on a specific date. This means that to everybody in `America/Chicago` and east of me, the date should be that specific date. But technically, to everybody west, the blog post went live on the day _before_.

So, with this as my final goal, I went ahead to try to implement this in five steps:

### 1️. The entire Jekyll site must build in UTC

This was easy. I set the following in my `_config.yml`:
```yml
timezone: UTC
```

I also took this opportunity to remove the `export TZ=America/Chicago` from my `.travis.yml`, since now the Jekyll site and Travis CI will naturally be on the same wavelength.

### 2️. Add the specific date/time of each blog posts' publish time

This was also pretty easy. You can just add the date to the front matter of each blog post:

```yml
date: 2020-01-17 22:15:00 -0600
```

You can specify the time the post should be published as well, although, as I stated above, I normally just use `00:00:00`, or midnight. For what I'm working with, the last part is important. That's the time zone offset. In Minnesota, that'll be `-0600` in the winter time (CST), or `-0500` in the summer (CDT)—I always used to get those two mixed up. But, I've decided that I want this to be easy for me to use going forward... so I should always write the date/time as I'm looking at my clock (in 24 hour time of course) with my current time zone offset 📝.

### 3️. Jekyll will store the blog post as being published in UTC

When I put both of these pieces together, the result was immediate. As soon as I ran `jekyll serve` on my website, I noticed that the `feed.xml` and `sitemap.xml` label the published date/time as in UTC! Yes! Nice and quick.

### 4️. Show the users the published date/time in their local time zones

This was by far the most challenging part. I played with a Jekyll plugin first, to see if there was an easy way to convert the UTC date/time to be in a different time zone. This would've worked, if I wanted to hard-code the new time zone (which defeats the purpose of it being flexible to the readers' location). So, after much googling, I realized the only good way to understand the readers' location and time zone offset is to use Javascript. Yay.... 😰

I'm not really a Javascript person. But, I jumped in anyway, and wanted to find a solution. Using some loop syntax from another slice of Javascript I use (read more about that [here](/blog/posts/opening-links-in-new-tabs-via-javascript/)), I started typing away. I want the Javascript to go through the HTML, find all of the dates, and then convert them to the readers' local time and print that back out again.

The entire script locates all of the HTML elements with the class `date-meta` (assuming that it is indeed a UTC date), and then Javascript makes it easy to change time zones:

```javascript
var monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
                  'July','August', 'September', 'October','November', 'December'
];
var dateArray = '2020-01-18 04:15:00 +0000'.split(/[^0-9]/);
//  localDate = Fri Jan 17 2020 22:15:00 GMT-0600 (Central Standard Time)
var localDate = new Date(
  Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], dateArray[3], dateArray[4], dateArray[5])
);
var day = localDate.getDate(); // 17
var year = localDate.getFullYear(); // 2020
var monthIndex = localDate.getMonth(); // 0
return monthNames[monthIndex] + ' ' + day + ', ' + year; // January 17, 2020
```

All together, this now looks like this:

```html
<script type="text/javascript">
  function showDatesInLocalTime() {
    var dates = document.getElementsByClassName('date-meta');
    var monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
                      'July','August', 'September', 'October','November', 'December'
    ];

    for(counter = 0; counter < dates.length; counter++) {
      var htmlDate = dates[counter];
      var dateArray = htmlDate.innerHTML.trim().split(/[^0-9]/);
      var localDate = new Date(
        Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], dateArray[3], dateArray[4], dateArray[5])
      );
      var day = localDate.getDate();
      var year = localDate.getFullYear();
      var monthIndex = localDate.getMonth();
      htmlDate.innerHTML = monthNames[monthIndex] + ' ' + day + ', ' + year;
    };
  };
  showDatesInLocalTime();
</script>
```

I'm hiding a lot of the effort this took me... don't get me wrong, it took me what felt like _hours_ to develop this method, and I'm still finding bugs in it 🦟.

### 5️. Don't show the published date in the URL of the blog posts

In our example, I published a post on the 17th of January at night in CST. But we see now, that if I travel to France and look back at past blog posts, it'll look as if it was published on the 18th of January. BUT, the URL of the blog post will include the published date. See an example below:

<div class="text-center">
  <a data-flickr-embed="true" href="https://www.flickr.com/photos/184539266@N08/49498384557/in/album-72157710863695862/" title="Link to blog post including the date"><img class="image" src="https://live.staticflickr.com/65535/49498384557_42bd218c3d.jpg" width="500" height="31" alt="Link to blog post including the date"></a>
</div>

If the date the site is showing the reader is moving around depending on the readers' location, then this is confusing—the URL date won't change!

If I'm honest, having the date in the URL was never my favorite thing... it always bugged me. I just never cared quite enough to change it, and to deal with the redirects I'd have to set up. But given this inconsistency, I decided that I finally cared enough to make the shift ↪.

I added the `jekyll-redirect-from` plugin to my `_config.yml`. And from there, redirecting is actually quite easy. In the front matter of each blog post, I add the new URL of the blog post, and then redirect to the new URL from the old URL:

```yml
permalink: /blog/posts/opening-links-in-new-tabs-via-javascript/
redirect_from:
  - /blog/posts/2020-01-14-opening-links-in-new-tabs-via-javascript/
```

Now, when I navigate to my blog posts at the old URL, my browser automatically redirects to the new URL. Hopefully that prevents my SEO ranking from going down 😬.

## Conclusion

At the end of the day, this goal maybe wasn't too hefty. It maybe took about six hours of total effort. I haven't traveled yet to see if it works as expected, but I have a trip planned in about a month, so we'll see then 🤷🏻‍♀️.

The moral of the story is that time zones are complicated, but the most robust websites will take them into account. If your website has date/times, then you should show them to your users in their local times, if possible. And you should be careful when storing data with date/times to make sure they are all stored in the same time zone, so they don't get conflicted.

I'm still working on perfecting my time zone processing. It's complicated, and not all browsers react the same way to Javascript (who knew, right ¯\\\_(ツ)\_/¯). But, I'd strongly urge to you take the plunge on your website... it'll be worth it when your blog becomes internationally popular 😜.

---

EDIT: Since writing this blog post, I've moved my default branch to be `main`, instead of `release` and/or `source`. I originally named it `release` because the documentation I was following named it that, but realized lggater that the name `main` fit my workflow better. Also, I've moved my `master` branch to be called `gh-pages`, and I've updated this blog post accordingly.
