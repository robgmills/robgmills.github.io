---
layout: post
title: "TIL there's no way to get a list of all your AWS Resource Tags"
date: 2020-05-07
categories: development
link: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html
---

![AWS Tag Editor](/images/2020/05/07/aws-tag-editor.png)

This note isn't a success story.
I was looking for a way to list out all of our AWS Resource Tags to audit both the Tag Keys and Values.
Turns out, there isn't an easy, programmatic way to access this.
The closest thing is to go into the [AWS Tag Editor ](https://docs.aws.amazon.com/ARG/latest/userguide/tag-editor.html), search for all assets and export as a CSV.

This is shocking considering [Jeff Bezos' API Mandate to Amazon](https://gigaom.com/2011/10/12/419-the-biggest-thing-amazon-got-right-the-platform/) circa-2002.
Sure, you can get tags by going asset-by-asset.
But, what if you don't know all your cloud assets?
