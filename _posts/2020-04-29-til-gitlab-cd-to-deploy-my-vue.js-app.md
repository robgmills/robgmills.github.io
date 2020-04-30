---
layout: post
title: "TIL GitLab CD to deploy my Vue.js app"
date: 2020-04-29
categories: development
link: https://hackernoon.com/using-gitlab-ci-cd-to-auto-deploy-your-vue-js-application-to-aws-s3-9affe1eb3457
---

Building on what I learned last week, I deployed my Vue.js application to Amazon Web Services (AWS) using GitLab's CI/CD.

I host all my personal, private repositories in GitLab.
I only keep a public presence in GitHub, but I imagine the experience is pretty similar.

I added a bunch of Terraform to the repository to create the necessary deployment target - an S3 bucket - and a set of IAM credentials with access limited to that S3 bucket for the GitLab CI/CD pipeline to use to copy the static assets.

I ran into a few problems:

* I set up my AWS credentials environment variables as protected, meaning I spent an hour+ trying to figure out why they weren't being found in my test branch
* I found GitLab's documentation for CI/CD to not be intuitive - maybe I'm spoiled by Auth0's awesome docs.
* I threw myself into a panic by accidentally messing with my account-wide S3 bucket permissions settings.

Something cool I learned was how to expose the S3 bucket publicly as a static website _without setting an ACL of `public-read`_.
Rather than do that, it's better to set up a more restrictive, but still publicly visible bucket policy:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow", 
            "Principal": "*", 
            "Action": "s3:GetObject", 
            "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*" 
        } 
    ] 
}
```

This is actually what sent me into a panic.
I had to manually edit my account-wide bucket permissions settings to **temporarily** allow the bucket to get created with a public policy.
Maybe some added ansible in here would have allowed me to turn the setting on and off again without manually intervening. 
