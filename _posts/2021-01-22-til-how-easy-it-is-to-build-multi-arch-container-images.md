---
layout: post
title: "TIL how easy it is to build multi-arch container images"
date: 2021-01-22
categories: development
link: https://docs.docker.com/buildx/working-with-buildx/#build-multi-platform-images
---

I seem to find that most of my personal projects end up running on a Raspberry Pi in my home network.
Raspberry Pis are a cheap source of compute suitable for most development tasks and non-critical workloads.
But they introduce an interesting problem: their CPU architectures are different than most developer workstations - mine included - and popular cloud compute options.
*It's been a long while since I've revisited this and recently I was super happy to find how easy Docker has made building multi-architecture container images that will run on both my workstation and my "production servers" for private and personal projects.*

This came up recently because I wanted to use the [open source `urlwatch` Python project](https://urlwatch.readthedocs.io/en/latest/) to monitor vendor web pages for a scarce consumer product good and notify my phone when it becomes available so that I could purchase only what I needed for personal use.

*Yes, I wanted to stand up my own bot to fight to bots I was up against.*

Fortunately, there's a published container image for urlwatch on Docker Hub: [vimagick/urlwatch](https://hub.docker.com/r/vimagick/urlwatch).

I was able to stand this up on my laptop workstation so that it notified me of changes to the stock availability of the products I wanted in a few hours - including refinement of the CSS selectors to make the notifications as grok-able as quickly as possible.
But every time I'd close my laptop lid, the container would suspend with my laptop and the monitoring would cease.
Time to deploy to "production!"

I've gotten use to deploying container applications to my Raspberry Pis, but when I did so this time, this is what I saw in the logs:

```sh
$ docker-compose up
Creating urlwatcher ... done
Attaching to urlwatcher
urlwatcher  | standard_init_linux.go:219: exec user process caused: exec format error
```

It's not the first time I've encountered this and I was pretty quickly able to identify that this is due to a image-vs-host CPU architecture mismatch.

Now, I'll be the first to admit that I hold on to computer hardware probably way too long.
I was deploying this out on a Raspberry Pi 3 B+, which runs a 32-bit ARMv7 Linux kernel by default.
I've used this Pi for the better part of 4 years now and haven't really had a *need* to upgrade to the much more powerful Raspberry Pi 4 yet.

The author of the container image has only published a version for `arm64` and not `arm/7` which I'd need to run on my Pi.  No sweat, I'll just build my own multi-arch version using Docker's new `buildx` experimental feature:

```sh
λ › docker buildx ls
NAME/NODE           DRIVER/ENDPOINT             STATUS  PLATFORMS
default             docker
  default           default                     running linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
λ › docker buildx create --name multiarchbuilder
λ › docker buildx ls
NAME/NODE           DRIVER/ENDPOINT             STATUS  PLATFORMS
multiarchbuilder *  docker-container
  multiarchbuilder0 unix:///var/run/docker.sock running linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
default             docker
  default           default                     running linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
λ › docker buildx use multiarchbuilder
λ › docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t robgmills/urlwatch:latest --push .
```

I should warn you, the builds for the virtualized ARM hardware were slow on my, also admittedly very old, Macbook Pro:

```sh
[+] Building 5006.4s (17/17) FINISHED
```

I wouldn't recommend running these multi-arch builds until you're really ready for them to be deployed and tested on a different set of hardware.

You can find [this multi-arch image in Docker Hub at robgmills/urlwatch](https://hub.docker.com/r/robgmills/urlwatch).
If you need a newer version of the image, [open an issue against my fork of the dockerfiles repository](https://github.com/robgmills/dockerfiles/issues).
If there are enough requests for updates, I'll set up CI/CD (and post about it ;P).