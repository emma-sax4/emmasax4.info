---
layout: post
title: DNS, Domains, and Personal Websites
tags: [ tech ]
draft: true
---

There's many companies that provide the ability for individuals to host their own websites. They include GitHub Pages (where this site is hosted), GitLab Pages, WordPress, Blogger, Wix, Google Sites, Weebly, HostGator, GoDaddy, and even The Knot. That's only naming a few. Every single site has their own pros and cons. Some provide more themes, some provide more flexibility but require the user to know how to code, some are completely free but usually sacrifice flexibility and theme options, some start as free but then have payment plans to get more features, etc.

Individuals may choose different hosting options for different websites, depending on their needs for the site. As an example, I have two maintained websites on my domain. This is my first one. I host on GitHub Pages because I feel comfortable enough to code and maintain my own site, and I like the flexibility it provides. But I also host a site on Google Sites. I host there because it doesn't need a fancy theme, and setup needed to be extra fast (this site I managed to set up within four hours with no pain).

People may choose to have a website for multiple reasons, including: personal blogs, advertisement of themselves and their career, a business they're starting, etc. The good news of the internet is that people can basically make a website for whatever they want (my partner once had one that just had a bunch of pictures of legos he made). The bad news is that unless you specifically set your website to be private (and that feature is only available from some hosting companies), anybody browsing the web can find your website. Pros and cons, right?

But, one thing is for certain. Basically, no matter how where you decide to host your website, there's going to be an option to provide your own domain.

Most of these sites will provide you with half-customized domain. This could look like `myblog.wordpress.com` or `firstnamelastname.weebly.com` or `github-user.github.io`. For the company, this is really easy to do. The user can choose whatever the front portion of that should be (called a `subdomain`). And then the back portion (the `domain` itself—ex: `wordpress.com`, `weebly.com`) functions both as an advertisement for their service, and it is easy to manage and make SSL certificates for (it's what's called a wildcard domain: `*.wordpress.com`).

But, for many individuals, that's not quite enough customization for their website (including myself). For whatever reason we each choose, we don't want to advertise where our website was hosted just by the URL.

So, for some small amount of money annually (usually around $10–$15 per year), an individual can purchase a custom domain name. Each domain name is unique. So since `facebook.com` is already purchased, nobody else can get this domain. Hopefully nobody's name is `Faceb Ook`. My domain for my website is `emmasax4.info`, so nobody else can buy that, but they could buy `emmasax4.com`, or `emmasax.info`.

A URL (or Uniform Resource Locator) has multiple parts to it. The first part is the protocol identifier. This is typically `http` or `https` (the `s` means secure connection with an SSL certificate). Other examples of protocols may be `ftp` or `telnet`. The last two portions (`example.com`) is the domain. This the unique name that indicates where the website is being served from. The ending part (`.com`, `.org`, `.edu`, `.net`, `.gov`, etc) indicates the top level domain designator. Here are some common top-level domains:

<div class="table-responsive-sm">
  <table class="table table-hover">
    <tbody>
      <tr>
        <td class="code">.com</td>
        <td>Commercial Entity</td>
        <td>Most common for companies that wish to advertise and sell a product.</td>
      </tr>
      <tr>
        <td class="code">.org</td>
        <td>Organization</td>
        <td>This includes nonprofit organizations.</td>
      </tr>
      <tr>
        <td class="code">.edu</td>
        <td>Educational Institution</td>
        <td>This could include universities, colleges, and high schools.</td>
      </tr>
      <tr>
        <td class="code">.net</td>
        <td>Network Provider</td>
        <td>Originally designated for companies involved with internet organizations.</td>
      </tr>
      <tr>
        <td class="code">.gov</td>
        <td>Government</td>
        <td>Originally only for the federal government, but now it includes any level of government.</td>
      </tr>
    </tbody>
  </table>
</div>

Sometimes, the top-level domain is also a country code, such as `.us`, `.ca`, `.de`, etc.

The next part in (`example`) is the unique identifier, and is a form of a subdomain. This is what individuals can typically customize.

Anything before that (including a `www`) is a subdomain. The history of `www` is sort of old-fashioned. It was first made with the idea that every single domain would start with this, as it stands for World Wide Web. But now, that's outdated, and it's more common for websites to just omit that portion of the URL entirely.

An individual can also use subdomains to have "multiple websites" that are all part of the same website (ex: `example.com` and `blog.example.com`).

Individuals can also use their domain as a part of their email (for the ultimate professional look). This would look like `jsmith@example.com`, and the domain would be `example.com`.

Okay, now that we've done an overview of domains, we can talk about DNS. DNS stands for Domain Name System, and is what the internet uses to map each domain to IP addresses of the server that's hosting the website. Because IP addresses actually shift around a decent amount, and they're ugly to look at, we often map domains to other domains, which then will map all over the place to get to a final destination IP address. But all you—as the reader—needs to know is that when you purchase a domain, whatever service you purchase that from is also going to give you a DNS. And it's in _that_ DNS where you can define where you want your domain name(s) to map to.

There's several different types of configurations. The basic thing to know is that there are `A Records`, `ALIAS Records`, and `CNAME Records`. `A Records` map a domain to an IP address (when the IP address is known and stable). A `CNAME Record` maps a domain to another domain (leading to that daisy chain I was briefly describing in the paragraph above). `ALIAS Records` are a lot like `CNAME Record`s, but they can coexist with other records on that name.

So, let's walk through what some of these DNS records may look like if you set up your website on a few different host providers. Note that TTL stands for Time to Live, and it specifies how long a resolver is supposed to cache the DNS query before looking for any new DNS queries.

DNS records when setting up your website with your main domain on GitHub Pages:
```
    Type               Host                 Value                     TTL
-------------------------------------------------------------------------------
ALIAS Record            @            github-user.github.io.        Automatic
CNAME Record           www               mydomain.com.             Automatic
```

DNS records when setting up your website your your main domain on Google Sites:
```
    Type               Host                 Value                     TTL
-------------------------------------------------------------------------------
ALIAS Record             @            ghs.googlehosted.com.        Automatic
CNAME Record            www               mydomain.com.            Automatic
TXT Record               @          google-site-verification=...   Automatic
```

DNS records when setting up your website with your main domain on Wordpress:
```
    Type               Host                 Value                     TTL
-------------------------------------------------------------------------------
ALIAS Record            @             NS1.WORDPRESS.COM.           Automatic
ALIAS Record            @             NS2.WORDPRESS.COM.           Automatic
ALIAS Record            @             NS3.WORDPRESS.COM.           Automatic
CNAME Record           www               mydomain.com.             Automatic
```

DNS records when setting up your website with a subdomain on GitHub Pages:
```
    Type               Host                 Value                     TTL
-------------------------------------------------------------------------------
CNAME Record         subdomain       github-user.github.io.        Automatic
CNAME Record       www.subdomain     subdomain.mydomain.com.       Automatic
```

DNS records when setting up your website with a subdomain on Google Sites:
```
    Type               Host                 Value                     TTL
-------------------------------------------------------------------------------
CNAME Record         subdomain        ghs.googlehosted.com.        Automatic
CNAME Record       www.subdomain     subdomain.mydomain.com.       Automatic
TXT Record           subdomain     google-site-verification=...    Automatic
```

DNS records when setting up your website with a subdomain on Wordpress:
```
    Type               Host                 Value                     TTL
-------------------------------------------------------------------------------
CNAME Record         subdomain     wordpress-site.wordpress.com.   Automatic
CNAME Record       www.subdomain     subdomain.mydomain.com.       Automatic
```

I haven't worked with adding domains to any other website host providers, so I can't speak to any other providers' information. But, when a person goes to add a domain to their website, there's usually plenty of (decently 🤞🏼) helpful documentation to get started.

So there you go! Hopefully this has helped you either learn more about DNS and domains, or will help you in choosing your personal domain and setting it up on your new website! Best of luck. I can attest that having your own website can be fun! It gives you a fun hobby and project, and it's definitely something that you can be proud of.
