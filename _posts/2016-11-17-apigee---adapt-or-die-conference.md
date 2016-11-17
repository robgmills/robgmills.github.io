---
layout: post
title: "Apigee - Adapt or Die Conference"
date: 2016-11-17
categories: development
---

I attended the [Apigee: Adapt or Die conference](https://apigee.com/api-management/#/eventdetail/51) and thought I'd share a few notes about it.

### Takeaways

* DevPortal/API gateway demo script should be EXACTLY like Twilio's/Walgreen's.
* Add "staging" site to build/test Apigee configuration changes.
* We need to build a community site/support from the get-go.
* Need to treat Apigee configuration as code - add to SCM immediately.
* Apigee configuration is all XML - seems a lot like Nifi.

### Sessions

I attended the following [sessions](https://apigee.com/api-management/#/eventdetail/51):

* Adapt or Die Opening Keynote - Chet Kapoor, Apigee, CEO
* Kubernetes: A microservices Story at Google - Dan Paik, Google, Product Manager
* How to turn APIs into "A Profit Increase" - Drew Schweinfurth, Walgreens, Developer Evangelist (API program)/Sean McCarthy, Charles Schwab, Managing Director (Solution Architecture)/Bryan Kirschner, Apigee, Strategy & Research Lead (Moderator)
* Best Practices for Platform Revolution - Drew Schweinfurth/Monica Lim, Experian, VP Global Architecture/Sven Loberg, Accenture, Director/Bryan Kirshner
* Innovation Showcase Keynote - Drew Schweinfurth/
* API-First Development with Apigee Edge (DevJam)

If you're interested in knowing more about a particular session I attended, let me know. I'd be happy to talk about it.

### Interesting Things

* Most of the companies in attendance are larger, consumer-focused companies looking to transition to a data-focused company.
* Heavy emphasis on "cloud-native computing" - signaling that a lot of those in the audience practice more antiquated infrastructure practices.
* All presented success stories are "start with a product, move to a platform".
We're unique that we're starting with the platform - _but does that mean we're missing context?_
* No one showed any real metrics about API adoption/use by third-parties.
* Google Kontainer Engine (GKE) makes all releases availabe 3-5 days after they're cut.
That's how long it takes to deploy them across their data centers.
* Google launches 2B containers per week and has been using containers for over 12 years.
* Alpha features for GKE are only available in alpha clusters that are torn down every 30 days to discourage use in production.
* Apigee focusing on container-native API management.

### Regret

The formal talks sucked - they were all marketing.
But the breakout/community/meetup sessions were where all of the good information was provided.
If you have any idea how Apigee works at all or what value it provides, go to those instead of the formal talks.