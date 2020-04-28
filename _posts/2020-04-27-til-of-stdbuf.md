---
layout: post
title: "TIL of stdbuf"
date: 2020-04-27
categories: development
link: https://linux.die.net/man/1/stdbuf
---

Today, I learned of `stdbuf` from a member of my team, Jim Werwath.
`stdbuf` allows you to modify the default buffering behavior of an existing program's handling of *nix's [standard streams](https://en.wikipedia.org/wiki/Standard_streams): `stdin`, `stdout` and `stderr`.

I haven't found an actual use for it yet, but it seems to be best suited for when a program, such as `cut`, waits until reading the entire input or writing the entire output to one of the standard streams before flushing.
Using `stdbuf` allows you to process every line (or otherwise defined "chunk") as soon as its written to one of the standard streams.
Jim used it in one of our CI/CD jobs, but I didn't look too closely at it yet.

I almost wasn't going to write todays post.
I learned of this much earlier today, but didn't grok what it did until this evening.
I'm glad I took the time to dig in a bit further.
