---
layout: post
title: "Serving Github Pages via HTTPS with CloudFlare"
date: 2016-01-08
category: development
link: https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/
---

I had to do some exploration into CDN and site optimization options as part of a 
"Buy vs. Build" analysis.  One option stood out above the rest in [CloudFlare][cloudflare].
I took the opportunity to use this site to not only evaluate the performance boost,
but also finally serve the site over HTTPS.

This site is a perfect candidate to evaluate baseline performance since it is a pure 
static site.  With added dynamicism through custom pages rendered server side adds a 
bit of complexity, but the numbers track similarly.

CDN and site optimizers like CloudFlare employ regionally located servers cache your 
static content closer to your users, thereby reducing the number of hops, thereby 
reducing the load times for your site.  It also provides for lighter load on your 
servers, and decreased bandwidth.

![CloudFlare&apos;s regional map of servers](https://www.cloudflare.com/media/network-map.png)

They&apos;re services also include traffic analysis to mitigate DDOS attacks, 
prevent (basic) SQL injection attacks, and give another source for analytics into
site access patterns by everything from users to site crawlers.

I like that CloudFlare serves as an in-line cache.  At previous employers, we had 
utilized a really messed up implementation of the [Akamai][akamai] services that 
required copying a bulk of our static content to a separate server that the CDN
would poll for updates.  It made the deployment and maintenance much more of a 
headache.  However, with CloudFlare, setup was a breeze (see directions below).

![CloudFlare in-line optimization](https://www.cloudflare.com/overview/overview.png)

### Set up HTTPS for gh-pages on CloudFlare

0. [Sign up for a free CloudFlare account.][cloudflare-free]

0. Make sure that all the records in your existing Zone file are copied over...

0. Update the DNS Nameservers in your domain registrar to point to those at CloudFlare...

    ![Old nameservers, meet new nameservers](https://i.imgur.com/Ru2nBJ7.png)

0. Change SSL settings from `Full` to `Flexible`...

    ![Flexible](https://i.imgur.com/IFuhab2.png)

0. Setup Page Rule to match all urls to force HTTPS...

    URL Pattern: `http://yourdomain.com/*`

    Always use https: `On`

    ![CloudFlare Page Rule](https://i.imgur.com/95H0Mwt.png)

0. Update your jekyll configuration to include https in the site `url` property and 
enable the `enforce_ssl` property...

    ```
    url: "https://yourdomain.com"
    enforce_ssl: yourdomain.com
    ```

0. Make sure the `canonical` link in your DOM `head`...

    ```
    <head>
        ...
        <link rel="canonical" href="{{ page.url | replace:'index.html','' | prepend: site.baseurl | prepend: site.url }}">
        ...
    </head>
    ```

0. Revel in your new found security

    ![Imgur](https://i.imgur.com/4fsDSe2.png)

### Performance Comparison

I was all setup to run some actual performance tests this evening from home and post 
the numbers, but I came home to wildly varying internet speeds:

![Go, Comcast! Go!](http://i.imgur.com/3w8o1iK.png)

I&apos;ll post numbers soon.

[cloudflare]: https://www.cloudflare.com
[akamai]: https://www.akamai.com/
[cloudflare-free]: https://www.cloudflare.com/a/sign-up
