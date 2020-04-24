---
layout: post
title: "TIL about Concourse fly targets"
date: 2020-04-23
categories: development
link: https://concourse-ci.org/fly.html#fly-targetsd
---

At work we use [Concourse CI](https://concourse-ci.org/) for continuous integration and delivery.
It encourages interacting with it via the `fly` commandline interface (CLI).
It also requires everyone to log in to it, and be a part of a team, to do a form of role based access control (RBAC).
Today, I lost about 30 minutes trying to figure out why my new pipelines weren't being deployed to the correct team in Concourse.
It was because I had set up my `fly target` incorrectly.

A _target_ is essentially a separate `fly` session.
When you log in to the `fly` CLI, you specify

* A target name underwhich to store the session creds
* The Concourse CI server URL at which to log in
* An optional team name to log in as

If you don't specify the optional team name, it will use the default.  
In my case, our default team is `main`.

Then, whenever you try to deploy your pipeline like so:

```sh
fly -t $target_name set-pipeline --pipeline my-awesome-pipeline --config my-awesome-pipeline.yml
```

The pipeline is deployed to the team space in Concourse for the team specified by your target.

You can view all your configured targets using the `fly targets` command:

```sh
λ › fly targets
name       url                                      team       expiry
rgmt       https://concourse.test.robgmills.com     test       Sat, 25 Apr 2020 00:25:24 UTC
rgm        https://concourse.live.robmills.com.com  admin      Sat, 25 Apr 2020 00:25:24 UTC
```

You can delete and edit targets:

```sh
λ › fly -t rgmt delete-target
deleted target: rgmt
λ › fly -t rgm edit-target --team-name live --target-name rgm-live --concourse-url https://concourse.live.robgmills.com
Updated target: rgm
```

I needed to learn this so I could deploy a new pipeline at work.
In the process, I killed two birds with one stone: added a CD pipeline that terraformed our Auth0<>SumoLogic integration and user acceptance tested one of the new CI/CD features my team built.
