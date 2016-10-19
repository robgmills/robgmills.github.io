---
layout: post
title: "bb-scan: a utility to clone all Bitbucket repos"
date: 2016-10-18
categories: development
---

A post is long overdue.  It's been a crazy year: [Uptake](https://uptake.com) has blown up; I've learned a ton; and we're nearing the
end of remodeling our home.  The cool thing is, I'm still finding (some) time to code.  Today, I present one of my "projects." 

[`bb-dump`: a utility to clone all Git repositories from an enterprise instance of Bitbucket/Stash.](https://github.com/robgmills/bb-dump)

I've found, at Uptake in particular, that most of the coding I do as a manager is write utilities to help me gather information to feed 
to my teams.  I rarely (read: "Never") get to pull mission critical stories because most of my time is spent making decisions or 
hoping from blocked engineer to blocked engineer - pairing, whiteboarding, debugging, or facilitating.

Not that I'm complaining.  I'm finding that there's no limit to the impact I can have as a manager - either in terms of breadth or depth.

One of the things I often find myself doing is tracking down problems in the code.  In older versions of Bitbucket Server (formerly known
as Stash), it was impossible to search for code.  Period.  It was long rumored that Atlassian would be introducing a code search feature
in an upcoming release, and [it was finally announced on March 24th](https://blog.bitbucket.org/2016/03/24/introducing-code-search-for-bitbucket-server/).

But Uptake wouldn't get it installed until this past Monday, October 17th - nearly 7 months later.  In the meantime, I still had to
track down examples.  Plus, with a 300 person engineering team, it was getting hard to keep up with the changes.

So I wrote `bb-dump`.  It uses the [stashy](https://github.com/RisingOak/stashy) python client under the hood to traverse the project/repository
structure of Bitbucket Server, retrieving a set of repository URLs with which `bb-dump` clones if not already on the local disk, or updates
if present.

Now that Uptake has the latest version of Bitbucket Server, I'm not sure how much I'll be adding to this script.  I'll definitely still
be using it to keep my local copies of the code up-to-date, but some of the other features I saw in the roadmap are obsolete.  Anyway, I 
welcome input in the form of pull requests, issues, and the like.  If someone wants to take over ownership of the repo because you'd 
like to drive the product - please, by all means, let me know.
