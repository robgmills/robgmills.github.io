---
layout: post
title:  "Custom domains w/GitHub Pages and Heroku"
date:   2015-10-20
categories: development
link: http://stackoverflow.com/questions/9082499/custom-domain-for-github-project-pages
---

I slapped together an app on the MEAN stack and deployed it out on Heroku so that people could RSVP to our wedding 
([demo](http://rsvp.robandjax.com),[source](https://github.com/robgmills/wedding-rsvp)).  It allowed us to automatically 
aggregate the guest list. After the wedding, we wanted to use the domain we had purchased somehow.  We considered a 
travel blog, but, as you know, I've already got a blog that I barely manage.

Instead, we decided to create a [digital version of something we had seen while visiting married friends: a map that 
showed where in the world they had visited](http://www.robandjax.com)([source](https://github.com/robgmills/robandjax)).
Given my success [using Jekyll on GitHub Pages](https://help.github.com/articles/using-jekyll-with-pages/) and wanting 
to keep open the possibility of doing some more dynamic stuff later.

[Setting up the domain to work with the Heroku deployment was straightforward as Heroku has some pretty solid 
documentation around it](https://devcenter.heroku.com/articles/custom-domains).  Doing the same with GitHub Project 
Pages was a little harder to figure out.

First, create a CNAME file in the root of your project with one domain name in it: `www.yourdomain.com`.  Commit and 
push.

Next, in your DNS manager, setup a CNAME record for the `www` subdomain that points to `yourusername.github.io`.

Then, depending on what your DNS provider supports, you need to do one of the following:

- Setup a CNAME record for the root apex (`@`) and point it to `yourusername.github.io`, or
- Create two A records that point to `192.30.252.153` and `192.30.252.154`, or
- Setup domain forwarding so that the root apex redirects to `www.yourdomain.com`

Finally, wait til your name servers update:

       dig yourdomain.com +nostats +nocomments +nocmd

This is what takes the longest, so be patient. 

